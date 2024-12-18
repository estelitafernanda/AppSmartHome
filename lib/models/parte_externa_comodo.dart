
import 'package:appsmarthome/models/comodo.dart';

class ParteExternaModel extends Comodo {
  double luminosidade;

  ParteExternaModel({
    required String nome,
    bool lampadaLigada = false,
    required this.luminosidade,
  }) : super(lampadaLigada: lampadaLigada, nome: nome);


  factory ParteExternaModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return ParteExternaModel(
      nome: nomeComodo,
      lampadaLigada: json['lampada'] ?? false,
      luminosidade: (json['luminosidade'] ?? 0.0).toDouble(),
    );
  }


}