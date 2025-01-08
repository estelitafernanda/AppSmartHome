import 'package:appsmarthome/models/banheiro_comodo.dart';
import 'package:appsmarthome/models/cozinha_comodo.dart';
import 'package:appsmarthome/models/garagem_comodo.dart';
import 'package:appsmarthome/models/parte_externa_comodo.dart';
import 'package:appsmarthome/models/quarto_comodo.dart';
import 'package:appsmarthome/models/sala_comodo.dart';
import 'package:appsmarthome/service/auth_service.dart';
import 'package:appsmarthome/service/banheiro_service.dart';
import 'package:appsmarthome/service/cozinha_service.dart';
import 'package:appsmarthome/service/garagem_service.dart';
import 'package:appsmarthome/service/parte_externa_service.dart';
import 'package:appsmarthome/service/quarto_service.dart';
import 'package:appsmarthome/service/sala_service.dart';
import 'package:appsmarthome/ui/widgets/custom_button.dart';
import 'package:appsmarthome/ui/widgets/dados_card.dart';
import 'package:appsmarthome/ui/widgets/estado_botao.dart';
import 'package:appsmarthome/ui/widgets/controle_rgb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late QuartoModel quarto = QuartoModel(nome: "Quarto");
  late QuartoService quartoService;
  late SalaModel sala = SalaModel(nome: "Sala", lampadaLigada: false, luminosidade: 0, presencaDetectada: false);
  late SalaService salaService;
  late ParteExternaModel parteExterna = ParteExternaModel(nome: "Parte Externa", lampadaLigada: false, luminosidade: 0,);
  late ParteExternaService parteExternaService;
  late BanheiroModel banheiro = BanheiroModel(nome: "Banheiro", lampadaLigada: false);
  late BanheiroService banheiroService;
  late CozinhaModel cozinha = CozinhaModel(nome: "Cozinha", lampadaLigada: false, luminosidade: 0,);
  late CozinhaService cozinhaService;
  late GaragemModel garagem = GaragemModel(nome: "Garagem", lampadaLigada: false);
  late GaragemService garagemService;

  double? _luminosidade;
  bool _estaCarregando = true;

  @override
  void initState() {
    super.initState();
    quartoService = QuartoService(context);
    salaService = SalaService(context);
    parteExternaService = ParteExternaService(context);
    banheiroService = BanheiroService(context);
    cozinhaService = CozinhaService(context);
    garagemService = GaragemService(context);

    _carregarDados();

    // Atualiza dados da parte externa em tempo real
    parteExternaService.carregarParteExternaTempoReal("parteExterna").listen((dados) {
      setState(() {
        parteExterna = dados;
      });
    });

    parteExternaService.obterLuminosidadeTempoReal("parteExterna").listen((luminosidade) {
      setState(() {
        _luminosidade = luminosidade;
      });
    });
  }

  Future<void> _carregarDados() async {
    try {
      final quartoCarregado = await quartoService.carregarQuarto("quarto");
      final salaCarregada = await salaService.carregarSala("sala");
      final banheiroCarregado = await banheiroService.carregarBanheiro("banheiro");
      final cozinhaCarregada = await cozinhaService.carregarCozinha("cozinha");
      final garagemCarregada = await garagemService.carregarGaragem("garagem");

      setState(() {
        quarto = quartoCarregado;
        sala = salaCarregada;
        banheiro = banheiroCarregado;
        cozinha = cozinhaCarregada;
        garagem = garagemCarregada;
        _estaCarregando = false;
      });
    } catch (e) {
      print('Erro ao carregar dados: $e');
      setState(() {
        _estaCarregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Minha Casa Inteligente",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: _estaCarregando
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/smarthome.png',
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Bem-vindo à sua casa inteligente",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // QUARTO - Dados
                    _buildSectionTitle("QUARTO"),
                    _buildDataCardsRow(
                      "Temperatura", quartoService.tempoRealTemperatura("quarto"), Colors.orange, true,
                      "Umidade", quartoService.tempoRealUmidade("quarto"), Colors.blue, false,
                    ),

                    // Controle RGB
                    const SizedBox(height: 40),
                    RGBControl(
                      vermelho: quarto.vermelho_rgb,
                      verde: quarto.verde_rgb,
                      azul: quarto.azul_rgb,
                      onRedChanged: (value) {
                        setState(() {
                          quarto.atualizarRGB(value, quarto.verde_rgb, quarto.azul_rgb);
                        });
                        quartoService.atualizarCoresRGB(quarto);
                      },
                      onGreenChanged: (value) {
                        setState(() {
                          quarto.atualizarRGB(quarto.vermelho_rgb, value, quarto.azul_rgb);
                        });
                        quartoService.atualizarCoresRGB(quarto);
                      },
                      onBlueChanged: (value) {
                        setState(() {
                          quarto.atualizarRGB(quarto.vermelho_rgb, quarto.verde_rgb, value);
                        });
                        quartoService.atualizarCoresRGB(quarto);
                      },
                    ),
                    const SizedBox(height: 40),

                    // SALA - Dados
                    _buildSectionTitle("SALA"),
                    LightButton(
                      estadoLampada: sala.lampadaLigada,
                      onPressed: () async {
                        setState(() {
                          sala.alterarEstadoLampada();
                        });
                        await salaService.atualizarEstadoLampada(sala);
                      },
                    ),
                    const SizedBox(height: 40),

                    // PARTE EXTERNA - Dados
                    _buildSectionTitle("PARTE EXTERNA"),
                    LightButton(
                      estadoLampada: parteExterna.lampadaLigada,
                      onPressed: () async {
                        setState(() {
                          parteExterna.alterarEstadoLampada();
                        });
                        await parteExternaService.atualizarEstadoLampada(parteExterna);
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Luminosidade da parte externa: ${_luminosidade != null ? _luminosidade!.toStringAsFixed(2) + '%' : "Carregando..."}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 40),

                    // BANHEIRO - Dados
                    _buildSectionTitle("BANHEIRO"),
                    LightButton(
                      estadoLampada: banheiro.lampadaLigada,
                      onPressed: () async {
                        setState(() {
                          banheiro.alterarEstadoLampada();
                        });
                        await banheiroService.atualizarEstadoLampada(banheiro);
                      },
                    ),
                    const SizedBox(height: 40),

                    // COZINHA - Dados
                    _buildSectionTitle("COZINHA"),
                    LightButton(
                      estadoLampada: cozinha.lampadaLigada,
                      onPressed: () async {
                        setState(() {
                          cozinha.alterarEstadoLampada();
                        });
                        await cozinhaService.atualizarEstadoLampada(cozinha);
                      },
                    ),
                    const SizedBox(height: 40),

                    // GARAGEM - Dados
                    _buildSectionTitle("GARAGEM"),
                    LightButton(
                      estadoLampada: garagem.lampadaLigada,
                      onPressed: () async {
                        setState(() {
                          garagem.alterarEstadoLampada();
                        });
                        await garagemService.atualizarEstadoLampada(garagem);
                      },
                    ),
                    const SizedBox(height: 40),

                    // LOGOUT Button
                    CustomButton(
                      height: 100,
                      text: "Logout",
                      onClick: () => {
                        authService.signOut(),
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // Function to build section title with some margin
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Function to build two DataCards in a row
  Widget _buildDataCardsRow(String title1, Stream<String> dataStream1, Color color1, bool isTemperature1, 
                            String title2, Stream<String> dataStream2, Color color2, bool isTemperature2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildDataCard(title1, dataStream1, color1, isTemperature1),
        ),
        const SizedBox(width: 16), // space between the cards
        Expanded(
          child: _buildDataCard(title2, dataStream2, color2, isTemperature2),
        ),
      ],
    );
  }

  // Function to build a single DataCard
  Widget _buildDataCard(String title, Stream<String> dataStream, Color color, bool isTemperature) {
    return StreamBuilder<String>(
      stream: dataStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? "Sem dados";
        return DataCard(
          titulo: title,
          valor: data,
          cor: color,
          isTemperature: isTemperature,
        );
      },
    );
  }
}
