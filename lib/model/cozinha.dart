class Cozinha{
  bool gas;
  bool estadoLampada;

  Cozinha({
    this.gas = false,
    this.estadoLampada = false,
    });


  void alterarEstadoLampada(){
    estadoLampada = !estadoLampada;
  }

  factory Cozinha.fromJson(Map<String, dynamic> json){
    return Cozinha(
        estadoLampada: json['lampada'] ?? false,
        gas : json['gas'] ?? false
    );
  }


}