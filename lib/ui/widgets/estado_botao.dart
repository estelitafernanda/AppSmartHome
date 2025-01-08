import 'package:flutter/material.dart';

class LightButton extends StatelessWidget {
  final bool estadoLampada;
  final VoidCallback onPressed;

  const LightButton({required this.estadoLampada, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        estadoLampada ? Icons.lightbulb : Icons.lightbulb_outline,
        color: estadoLampada ? Colors.yellow : Colors.black,
      ),
      label: Text(estadoLampada ? "Desligar Luz" : "Ligar Luz"),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
      ),
    );
  }
}
