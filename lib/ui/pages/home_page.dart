import 'package:appsmarthome/models/quarto_comodo.dart';
import 'package:appsmarthome/service/quarto_service.dart';
import 'package:appsmarthome/ui/widgets/dados_card.dart';
import 'package:appsmarthome/ui/widgets/estado_botao.dart';
import 'package:appsmarthome/ui/widgets/controle_rgb.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late QuartoModel quarto;
  late QuartoService quartoService;
  bool _estaCarregando = true;

  @override
  void initState() {
    super.initState();
    quartoService = QuartoService(context);
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final comodoCarregado = await quartoService.carregarQuarto("quarto");

      setState(() {
        quarto = comodoCarregado;
        _estaCarregando = false;
      });
    } catch (e) {
      print('Erro ao carregar dados: $e');
      setState(() {
        _estaCarregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Minha Casa Inteligente",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: _estaCarregando
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Bem vindo a sua casa inteligente",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder<String>(
                stream: quartoService.tempoRealTemperatura("quarto"),
                builder: (context, snapshot) {
                  final temperatura = snapshot.data ?? "Sem dados";
                  return DataCard(
                    titulo: "Temperatura",
                    valor: temperatura,
                    cor: Colors.orange,
                    isTemperature: true,
                  );
                },
              ),

              const SizedBox(height: 20),
              StreamBuilder<String>(
                stream: quartoService.tempoRealUmidade("quarto"),
                builder: (context, snapshot) {
                  final umidade = snapshot.data ?? "Sem dados";
                  return DataCard(
                    titulo: "Umidade",
                    valor: umidade,
                    cor: Colors.blue,
                    isTemperature: false,
                  );
                },
              ),

              const SizedBox(height: 40),
              LightButton(
                estadoLampada: quarto.estadoLampada,
                onPressed: () async {
                  setState(() {
                    quarto.alternarEstadoLampada();
                  });
                  await quartoService.atualizarEstadoLampada(quarto);
                },
              ),
              const SizedBox(height: 40),
              RGBControl(
                vermelho: quarto.vermelho_rgb,
                verde: quarto.verde_rgb,
                azul: quarto.azul_rgb,
                onRedChanged: (value) {
                  setState(() {
                    quarto.atualizarRGB(value, quarto.verde_rgb, quarto.azul_rgb);
                  });
                  quartoService.atualizarCoresRGB(quarto);
                },
                onGreenChanged: (value) {
                  setState(() {
                    quarto.atualizarRGB(quarto.vermelho_rgb, value, quarto.azul_rgb);
                  });
                  quartoService.atualizarCoresRGB(quarto);
                },
                onBlueChanged: (value) {
                  setState(() {
                    quarto.atualizarRGB(quarto.vermelho_rgb, quarto.verde_rgb, value);
                  });
                  quartoService.atualizarCoresRGB(quarto);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}