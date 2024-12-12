// lib/widgets/controle_rgb.dart

import 'package:flutter/material.dart';

class RGBControl extends StatelessWidget {
  final int vermelho;
  final int verde;
  final int azul;
  final Function(int) onRedChanged;
  final Function(int) onGreenChanged;
  final Function(int) onBlueChanged;

  RGBControl({
    required this.vermelho,
    required this.verde,
    required this.azul,
    required this.onRedChanged,
    required this.onGreenChanged,
    required this.onBlueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Controle de RGB",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _buildSlider("Vermelho", vermelho, Colors.red, onRedChanged),
        _buildSlider("Verde", verde, Colors.green, onGreenChanged),
        _buildSlider("Azul", azul, Colors.blue, onBlueChanged),
      ],
    );
  }

  Widget _buildSlider(String label, int valor, Color cor, Function(int) onChanged) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: cor)),
        Slider(
          value: valor.toDouble(),
          min: 0,
          max: 255,
          divisions: 255,
          label: valor.toString(),
          activeColor: cor,
          onChanged: (newValue) => onChanged(newValue.toInt()),
        ),
      ],
    );
  }
}
