import 'package:appsmarthome/models/banheiro_comodo.dart';
import 'package:appsmarthome/service/banheiro_service.dart';
import 'package:appsmarthome/ui/widgets/estado_botao.dart';
import 'package:flutter/material.dart';


class BanheiroCard extends StatefulWidget {
  const BanheiroCard({super.key});

  @override
  State<StatefulWidget> createState() => _BanheiroCard();
}

class _BanheiroCard extends State<BanheiroCard> {
  bool _estaCarregando = true;
  late BanheiroModel banheiro = BanheiroModel(nome: "banheiro", lampadaLigada: false);
  late BanheiroService banheiroService;

  @override
  void initState() {
    super.initState();
    banheiroService = BanheiroService(context);
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final comodoCarregado = await banheiroService.carregarBanheiro("banheiro");

      setState(() {
        banheiro = comodoCarregado;
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
              "Banheiro",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Center(
              child: _estaCarregando
                  ? const CircularProgressIndicator()
                  : LightButton(
                estadoLampada: banheiro.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    banheiro.alterarEstadoLampada();
                  });
                  await banheiroService.atualizarEstadoLampada(banheiro);
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
