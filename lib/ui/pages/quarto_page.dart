import 'package:appsmarthome/service/quarto_service.dart';
import 'package:flutter/material.dart';
import 'package:appsmarthome/models/quarto_comodo.dart';
import 'package:appsmarthome/ui/widgets/controle_rgb.dart';

class QuartoDetalhesPage extends StatefulWidget {
  final QuartoModel quarto;

  const QuartoDetalhesPage({required this.quarto, Key? key}) : super(key: key);

  @override
  _QuartoDetalhesPageState createState() => _QuartoDetalhesPageState();
}

class _QuartoDetalhesPageState extends State<QuartoDetalhesPage> {
  late QuartoService quartoService;
  late Stream<String> umidadeStream;
  late Stream<String> temperaturaStream;

  @override
  void initState() {
    super.initState();
    quartoService = QuartoService(context);
    umidadeStream = quartoService.tempoRealUmidade(widget.quarto.nome);
    temperaturaStream = quartoService.tempoRealTemperatura(widget.quarto.nome);
  }

  void _atualizarRGB(int vermelho, int verde, int azul) async {
    try {
      setState(() {
        widget.quarto.vermelho_rgb = vermelho;
        widget.quarto.verde_rgb = verde;
        widget.quarto.azul_rgb = azul;
      });

      await quartoService.atualizarCoresRGB(widget.quarto);
    } catch (e) {
      print('Erro ao atualizar RGB: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Quarto"),
      ),
      body: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Quarto",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Card para Ar-condicionado e Temperatura fixa
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ar-condicionado: ${widget.quarto.estadoArCondicionado ? 'Ligado' : 'Desligado'}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Temperatura: ${widget.quarto.temperaturaArCondicionado}°C",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Card para Temperatura e Umidade em tempo real
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<String>(
                        stream: temperaturaStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return const Text("Erro ao carregar temperatura");
                          }
                          return Text(
                            "Temperatura: ${snapshot.data ?? 'Sem dados'}°C",
                            style: const TextStyle(fontSize: 18),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      StreamBuilder<String>(
                        stream: umidadeStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return const Text("Erro ao carregar umidade");
                          }
                          return Text(
                            "Umidade: ${snapshot.data ?? 'Sem dados'}",
                            style: const TextStyle(fontSize: 18),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              RGBControl(
                vermelho: widget.quarto.vermelho_rgb,
                verde: widget.quarto.verde_rgb,
                azul: widget.quarto.azul_rgb,
                onRedChanged: (value) => _atualizarRGB(value, widget.quarto.verde_rgb, widget.quarto.azul_rgb),
                onGreenChanged: (value) => _atualizarRGB(widget.quarto.vermelho_rgb, value, widget.quarto.azul_rgb),
                onBlueChanged: (value) => _atualizarRGB(widget.quarto.vermelho_rgb, widget.quarto.verde_rgb, value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
