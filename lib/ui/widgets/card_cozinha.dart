import 'package:appsmarthome/models/cozinha_comodo.dart';
import 'package:appsmarthome/service/cozinha_service.dart';
import 'package:appsmarthome/ui/widgets/estado_botao.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';


class CozinhaCard extends StatefulWidget {
  const CozinhaCard({super.key});

  @override
  State<StatefulWidget> createState() => _CozinhaCard();
}

class _CozinhaCard extends State<CozinhaCard> {
  bool _estaCarregando = true;
  late CozinhaModel cozi = CozinhaModel(nome: "cozinha", luminosidade: 0);
  late CozinhaService cozinhaService;
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  late Stream<DatabaseEvent> _gasStream;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    cozinhaService = CozinhaService(context);
    _carregarDados();
    _inicializarNotificacoes();
    _verificarPermissaoNotificacoes(); // Adicionado aqui
    _inicializarStreamGas();
  }

  Future<void> _carregarDados() async {
    try {
      final comodoCarregado = await cozinhaService.carregarCozinha("cozinha");

      setState(() {
        cozi = comodoCarregado;
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
  void _inicializarStreamGas() {
    _gasStream = _databaseRef.child('casa/cozinha/gas').onValue;

    _gasStream.listen((event) {
      final valorGas = event.snapshot.value;

      if (valorGas == true) {
        _acionarAlertaGas();
      }
    }, onError: (error) {
      print("Erro ao monitorar gás via stream: $error");
    });
  }

  /// Ação disparada quando o valor do gás for true
  void _acionarAlertaGas() {
    _mostrarNotificacao();

    // Opcional: Exibir um diálogo de alerta na interface do app
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alerta de Gás!"),
          content: const Text("Um nível perigoso de gás foi detectado na cozinha."),
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
      'gas_alert_channel',
      'Alerta de Gás',
      channelDescription: 'Notificação para alertar sobre níveis perigosos de gás.',
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
      'Alerta de Gás!', // Título
      'Um nível perigoso de gás foi detectado na cozinha.', // Corpo
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
              "Cozinha",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: _estaCarregando
                  ? const CircularProgressIndicator()
                  : LightButton(
                estadoLampada: cozi.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    cozi.alterarEstadoLampada();
                  });
                  await cozinhaService.atualizarEstadoLampada(cozi);
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
