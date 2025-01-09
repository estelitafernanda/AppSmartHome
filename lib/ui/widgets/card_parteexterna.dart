import 'package:appsmarthome/models/parte_externa_comodo.dart';
import 'package:appsmarthome/service/parte_externa_service.dart';
import 'package:flutter/material.dart';

class ParteExternaCard extends StatefulWidget {
  const ParteExternaCard({Key? key}) : super(key: key);

  @override
  State<ParteExternaCard> createState() => _ParteExternaCardState();
}

class _ParteExternaCardState extends State<ParteExternaCard> {
  late ParteExternaService parteService;

  @override
  void initState() {
    super.initState();
    parteService = ParteExternaService(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ParteExternaModel>(
      stream: parteService.carregarParteExternaTempoReal("parteExterna"),
      builder: (context, snapshot) {
        // Se os dados estão carregando, exibe um indicador de progresso
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Se ocorrer um erro ao carregar os dados
        if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
        }

        // Se não houver dados, exibe uma mensagem
        if (!snapshot.hasData) {
          return const Center(child: Text('Sem dados disponíveis.'));
        }

        // Se houver dados, pega os dados carregados
        final parteExterna = snapshot.data!;

        // Retorna o layout do Card com os dados
        return Card(
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
                  "Parte Externa",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Exibição do estado da lâmpada
                Text(
                  "Lâmpada: ${parteExterna.lampadaLigada ? 'Ligada' : 'Desligada'}",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "Luminosidade: ${parteExterna.luminosidade} lux",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                // Botão de ligar/desligar lâmpada
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        parteExterna.lampadaLigada = !parteExterna.lampadaLigada;
                      });
                      await parteService.atualizarEstadoLampada(parteExterna);
                    },
                    child: Text(parteExterna.lampadaLigada ? "Desligar" : "Ligar"),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
