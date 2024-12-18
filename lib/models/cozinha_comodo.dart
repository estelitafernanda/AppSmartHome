import 'package:appsmarthome/models/comodo.dart';

class CozinhaModel extends Comodo {
  int luminosidade;
  //bool sensorGas;

  CozinhaModel({
    required String nome,
    bool lampadaLigada = false,
    required this.luminosidade,
  }) : super(lampadaLigada: lampadaLigada, nome: nome);

  factory CozinhaModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return CozinhaModel(
        nome: nomeComodo,
        lampadaLigada: json['lampada'] ?? false,
        luminosidade:  json['luminosidade'] ?? 0,
    );
  }

}