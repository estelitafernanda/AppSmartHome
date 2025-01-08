import 'package:appsmarthome/models/comodo.dart';

class CozinhaModel extends Comodo {
  String nome;
  double luminosidade;
  bool sensorGas;

  CozinhaModel({
    required this.nome,
    bool lampadaLigada = false,
    required this.luminosidade,
    this.sensorGas = false,
  }) : super(lampadaLigada: lampadaLigada);

  factory CozinhaModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return CozinhaModel(
        nome: nomeComodo,
        lampadaLigada: json['lampada'] ?? false,
        luminosidade:  json['luminosidade'] ?? 0,
        sensorGas: json['gas'] ?? false,
    );
  }

}