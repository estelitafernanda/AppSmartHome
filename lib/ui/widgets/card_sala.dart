import 'package:appsmarthome/models/sala_comodo.dart';
import 'package:appsmarthome/service/sala_service.dart';
import 'package:appsmarthome/ui/widgets/estado_botao.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';


class SalaCard extends StatefulWidget {
  const SalaCard({super.key});

  @override
  State<StatefulWidget> createState() => _SalaCard();
}

class _SalaCard extends State<SalaCard> {
  bool _estaCarregando = true;
  late SalaModel sala = SalaModel(nome: "sala", luminosidade: 0, presencaDetectada: false);
  late SalaService salaService;
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  late Stream<DatabaseEvent> _presencaStream;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    salaService = SalaService(context);
    _carregarDados();
    _inicializarNotificacoes();
    _verificarPermissaoNotificacoes(); // Adicionado aqui
    _inicializarStreamSala();
  }

  Future<void> _carregarDados() async {
    try {
      final comodoCarregado = await salaService.carregarSala("sala");

      setState(() {
        sala = comodoCarregado;
        _estaCarregando = false;
      });
    } catch (e) {
      print('Erro ao carregar dados: $e');
      setState(() {
        _estaCarregando = false;
      });
    }
  }

  /// Inicializa as notificações locais
  void _inicializarNotificacoes() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Verifica e solicita permissão de notificações para Android 13+
  Future<void> _verificarPermissaoNotificacoes() async {
    // Verifica se o SDK é Android 13 ou superior
    final androidInfo = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();

    if (androidInfo != null && androidInfo.isEmpty) {
      final status = await Permission.notification.request();

      if (status != PermissionStatus.granted) {
        print("Permissão de notificações negada.");
        return;
      }
    }
  }

  /// Inicializa o stream para monitorar o campo "gas"
  void _inicializarStreamSala() {
    _presencaStream = _databaseRef.child('casa/sala/presenca').onValue;

    _presencaStream.listen((event) {
      final valorPresenca = event.snapshot.value;

      if (valorPresenca == true) {
        _acionarAlertaPresenca();
      }
    }, onError: (error) {
      print("Erro ao monitorar gás via stream: $error");
    });
  }

  /// Ação disparada quando o valor do gás for true
  void _acionarAlertaPresenca() {
    _mostrarNotificacao();

    // Opcional: Exibir um diálogo de alerta na interface do app
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alerta de Presença!"),
          content: const Text("Uma presença foi detectada."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  /// Mostra uma notificação local no telefone
  Future<void> _mostrarNotificacao() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'presenca_alert_channel',
      'Alerta de Presença',
      channelDescription: 'Notificação para alertar sobre presença.',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      0, // ID da notificação
      'Alerta de Presença!', // Título
      'Uma presença foi detectada.', // Corpo
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sala",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Center(
              child: _estaCarregando
                  ? const CircularProgressIndicator()
                  : LightButton(
                estadoLampada: sala.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    sala.alterarEstadoLampada();
                  });
                  await salaService.atualizarEstadoLampada(sala);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
