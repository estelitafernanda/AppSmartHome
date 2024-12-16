class QuartoModel {
  final String nome;
  String? temperatura;
  String? umidade;
  int vermelho_rgb, verde_rgb, azul_rgb;

  QuartoModel(
    {
      required this.nome,
      this.temperatura,
      this.umidade,
      this.vermelho_rgb = 0,
      this.verde_rgb = 0,
      this.azul_rgb = 0
    }
  );

  void atualizarRGB(int r, int g, int b) {
    vermelho_rgb = r;
    verde_rgb = g;
    azul_rgb = b;
  }

  factory QuartoModel.fromJson(String nomeComodo, Map<String, dynamic> json) {
    return QuartoModel(
        nome: nomeComodo,
        temperatura: json['temperatura']?.toString() ?? "Sem dados",
        umidade: json['umidade']?.toString() ?? "Sem dados",
        vermelho_rgb: json['red'] ?? 0,
        verde_rgb: json['green'] ?? 0,
        azul_rgb: json['blue'] ?? 0
    );
  }

}