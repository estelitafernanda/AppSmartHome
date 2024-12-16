import 'package:appsmarthome/models/comodo.dart';

class BanheiroModel extends Comodo {
  String nome;

  BanheiroModel({
    required this.nome,
    bool lampadaLigada = false,
  }) : super(lampadaLigada: lampadaLigada);


  factory BanheiroModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return BanheiroModel(
        nome: nomeComodo,
        lampadaLigada: json['lampada'] ?? false,
    );
  }

}