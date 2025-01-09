import 'package:appsmarthome/models/comodo.dart';

class GaragemModel extends Comodo {
  String nome;
  bool estadoMotor = false;


  GaragemModel({
    required this.nome,
    bool lampadaLigada = false,
    this.estadoMotor = false,

  }) : super(lampadaLigada: lampadaLigada);


  factory GaragemModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return GaragemModel(
        nome: nomeComodo,
        lampadaLigada: json['lampada'] ?? false,
        estadoMotor: json['motor'] ?? false,

    );
  }

}