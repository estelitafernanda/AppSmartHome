import 'package:appsmarthome/models/comodo.dart';

class BanheiroModel extends Comodo {

  BanheiroModel({
    required String nome,
    bool lampadaLigada = false,
  }) : super(lampadaLigada: lampadaLigada, nome: nome);


  factory BanheiroModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return BanheiroModel(
        nome: nomeComodo,
        lampadaLigada: json['lampada'] ?? false,
    );
  }

}