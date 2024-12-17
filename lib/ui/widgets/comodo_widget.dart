import 'package:appsmarthome/models/quarto_comodo.dart';
import 'package:appsmarthome/service/quarto_service.dart';
import 'package:appsmarthome/ui/widgets/controle_rgb.dart';
import 'package:appsmarthome/ui/widgets/dados_card.dart';
import 'package:flutter/material.dart';

class QuartoWidget extends StatefulWidget {
  QuartoWidget({super.key,});

  @override
  State<QuartoWidget> createState() => _QuartoWidgetState();
}

class _QuartoWidgetState extends State<QuartoWidget> {

  bool _estaCarregando = true;
  late QuartoService quartoService;
  late QuartoModel quarto;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        )
      ],
    );
  }
}