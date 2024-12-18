import 'package:appsmarthome/models/comodo.dart';

class SalaModel extends Comodo {
  int luminosidade;
  bool presencaDetectada;

  SalaModel({
    required String nome,
    bool lampadaLigada = false,
    required this.luminosidade,
    required this.presencaDetectada
  }) : super(lampadaLigada: lampadaLigada, nome: nome);


  factory SalaModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
      return SalaModel(
      nome: nomeComodo,
      lampadaLigada: json['lampada'] ?? false,
      luminosidade: (json['luminosidade'] ?? 0.0).toDouble(),
      presencaDetectada: json['presencaDetectada'] ?? false
    );
  }

}