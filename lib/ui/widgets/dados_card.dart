// lib/widgets/dados_card.dart

import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final String titulo;
  final String valor;
  final Color cor;
  final bool isTemperature;

  DataCard({
    required this.titulo,
    required this.valor,
    required this.cor,
    required this.isTemperature,
  });

  @override
  Widget build(BuildContext context) {
    String formatoValor = isTemperature ? "$valor°C" : "$valor%";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cor, width: 2),
      ),
      child: Column(
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: cor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            formatoValor,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
