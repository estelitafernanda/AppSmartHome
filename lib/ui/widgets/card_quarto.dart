import 'package:appsmarthome/models/quarto_comodo.dart';
import 'package:appsmarthome/service/quarto_service.dart';
import 'package:appsmarthome/ui/pages/quarto_page.dart';
import 'package:flutter/material.dart';

class QuartoCard extends StatefulWidget {
  const QuartoCard({Key? key}) : super(key: key);

  @override
  State<QuartoCard> createState() => _QuartoCardState();
}

class _QuartoCardState extends State<QuartoCard> {
  bool isLightOn = false; // Estado para ligar/desligar a luz
  late QuartoService quartoService;
  bool _estaCarregando = true;

  // Inicializa o quarto com valores padrão
  QuartoModel quarto = QuartoModel(
    nome: "quarto",
    temperatura: "Sem dados",
    umidade: "Sem dados",
    vermelho_rgb: 0,
    verde_rgb: 0,
    azul_rgb: 0,
    estadoArCondicionado: false,
    temperaturaArCondicionado: 20,
  );

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
    if (_estaCarregando) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector(
      onTap: () {
        // Navegação para a tela de detalhes ao clicar no Card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuartoDetalhesPage(quarto: quarto),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título do Card
              const Text(
                "Quarto",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Exibição do estado do ar-condicionado
              Text(
                "Ar-Condicionado: ${quarto.estadoArCondicionado ? 'Ligado' : 'Desligado'}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Temperatura: ${quarto.temperaturaArCondicionado} °C",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Botão de ligar/desligar
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      quarto.alternarEstadoArCondicionado();
                    });
                    await quartoService.atualizarEstadoAr(quarto);
                  },
                  child: Text(quarto.estadoArCondicionado ? "Desligar" : "Ligar"),
                ),
              ),
              const SizedBox(height: 16),

              // Botões de aumentar e diminuir temperatura lado a lado
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: quarto.estadoArCondicionado
                        ? () async {
                            setState(() {
                              quarto.ajustarTemperaturaAr(
                                  (quarto.temperaturaArCondicionado ?? 24) + 1);
                            });
                            await quartoService.atualizarTemperaturaAr(quarto);
                          }
                        : null,
                    child: const Text("Aumentar"),
                  ),
                  ElevatedButton(
                    onPressed: quarto.estadoArCondicionado
                        ? () async {
                            setState(() {
                              quarto.ajustarTemperaturaAr(
                                  (quarto.temperaturaArCondicionado ?? 24) - 1);
                            });
                            await quartoService.atualizarTemperaturaAr(quarto);
                          }
                        : null,
                    child: const Text("Diminuir"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
