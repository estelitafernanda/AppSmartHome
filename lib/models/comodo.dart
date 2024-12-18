abstract class Comodo {
  bool lampadaLigada;

  Comodo({this.lampadaLigada = false});

  void alterarEstadoLampada() => lampadaLigada = !lampadaLigada;

}