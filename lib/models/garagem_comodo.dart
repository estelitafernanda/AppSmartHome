import 'package:appsmarthome/models/comodo.dart';

class GaragemModel extends Comodo {
  String nome;


  GaragemModel({
    required this.nome,
    bool lampadaLigada = false,
  }) : super(lampadaLigada: lampadaLigada);


  factory GaragemModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return GaragemModel(
        nome: nomeComodo,
        lampadaLigada: json['lampada'] ?? false,
    );
  }

}