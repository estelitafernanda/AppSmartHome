abstract class Comodo {
  String nome;
  bool lampadaLigada;

  Comodo({this.lampadaLigada = false, required this.nome});

  void alterarEstadoLampada() => lampadaLigada = !lampadaLigada;

}
