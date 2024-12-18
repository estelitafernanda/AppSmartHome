class QuartoModel {
  final String nome;
  String? temperatura;
  String? umidade;
  bool estadoLampada;
  int vermelho_rgb, verde_rgb, azul_rgb;

  // Propriedades do ar-condicionado
  bool estadoArCondicionado;
  double temperaturaArCondicionado;

  QuartoModel(
      {
        required this.nome,
        this.temperatura,
        this.umidade,
        this.estadoLampada = false,
        this.vermelho_rgb = 0,
        this.verde_rgb = 0,
        this.azul_rgb = 0,
        this.estadoArCondicionado = false,
        this.temperaturaArCondicionado = 0
      }
      );

  void alternarEstadoLampada() {
    estadoLampada = !estadoLampada;
  }

  void atualizarRGB(int r, int g, int b) {
    vermelho_rgb = r;
    verde_rgb = g;
    azul_rgb = b;
  }

  // Método para alternar o estado do ar-condicionado
  void alternarEstadoArCondicionado() {
    estadoArCondicionado = !estadoArCondicionado;
  }

  // Método para ajustar a temperatura do ar-condicionado
  void ajustarTemperaturaArCondicionado(double temperatura) {
    temperaturaArCondicionado = temperatura;
  }

  factory QuartoModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return QuartoModel(
        nome: nomeComodo,
        temperatura: json['temperatura']?.toString() ?? "Sem dados",
        umidade: json['umidade']?.toString() ?? "Sem dados",
        estadoLampada: json['luz'] ?? false,
        vermelho_rgb: json['red'] ?? 0,
        verde_rgb: json['green'] ?? 0,
        azul_rgb: json['blue'] ?? 0,
        estadoArCondicionado: json['ligado'] ?? false,
        temperaturaArCondicionado: (json['arCondicionado/temperatura'] != null) ? json['arCondicionado/temperatura'].toDouble() : null
    );
  }
}
