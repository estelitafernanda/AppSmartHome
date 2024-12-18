import 'package:appsmarthome/models/comodo.dart';

class GaragemModel extends Comodo {


  GaragemModel({
    required String nome,
    bool lampadaLigada = false,
  }) : super(lampadaLigada: lampadaLigada, nome: nome);


  factory GaragemModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return GaragemModel(
        nome: nomeComodo,
        lampadaLigada: json['lampada'] ?? false,
    );
  }

}