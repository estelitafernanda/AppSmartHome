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
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Controle de RGB",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 20),
          _buildSlider("Vermelho", vermelho, Colors.red, onRedChanged),
          SizedBox(height: 16),
          _buildSlider("Verde", verde, Colors.green, onGreenChanged),
          SizedBox(height: 16),
          _buildSlider("Azul", azul, Colors.blue, onBlueChanged),
        ],
      ),
    );
  }

  Widget _buildSlider(
      String label, int valor, Color cor, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: cor, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: cor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Slider(
            value: valor.toDouble(),
            min: 0,
            max: 255,
            divisions: 255,
            label: valor.toString(),
            activeColor: cor,
            inactiveColor: cor.withOpacity(0.4),
            onChanged: (newValue) => onChanged(newValue.toInt()),
          ),
        ),
      ],
    );
  }
}
