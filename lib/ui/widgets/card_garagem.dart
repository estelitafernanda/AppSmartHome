import 'package:appsmarthome/models/garagem_comodo.dart';
import 'package:appsmarthome/service/garagem_service.dart';
import 'package:appsmarthome/ui/widgets/estado_botao.dart';
import 'package:flutter/material.dart';


class GaragemCard extends StatefulWidget {
  const GaragemCard({super.key});

  @override
  State<StatefulWidget> createState() => _GaragemCard();
}

class _GaragemCard extends State<GaragemCard> {
  bool _estaCarregando = true;
  late GaragemModel garagem = GaragemModel(nome: "sala", lampadaLigada: false, estadoMotor: false);
  late GaragemService garagemService;

  @override
  void initState() {
    super.initState();
    garagemService = GaragemService(context);
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final comodoCarregado = await garagemService.carregarGaragem("garagem");

      setState(() {
        garagem = comodoCarregado;
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
              "Garagem",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Center(
              child: _estaCarregando
                  ? const CircularProgressIndicator()
                  : LightButton(
                estadoLampada: garagem.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    garagem.alterarEstadoLampada();
                  });
                  await garagemService.atualizarEstadoLampada(garagem);
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
