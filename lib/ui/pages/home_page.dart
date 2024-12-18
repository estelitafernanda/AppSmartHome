import 'package:appsmarthome/models/banheiro_comodo.dart';
import 'package:appsmarthome/models/cozinha_comodo.dart';
import 'package:appsmarthome/models/garagem_comodo.dart';
import 'package:appsmarthome/models/parte_externa_comodo.dart';
import 'package:appsmarthome/models/quarto_comodo.dart';
import 'package:appsmarthome/models/sala_comodo.dart';
import 'package:appsmarthome/service/banheiro_service.dart';
import 'package:appsmarthome/service/cozinha_service.dart';
import 'package:appsmarthome/service/garagem_service.dart';
import 'package:appsmarthome/service/parte_externa_service.dart';
import 'package:appsmarthome/service/quarto_service.dart';
import 'package:appsmarthome/service/sala_service.dart';
import 'package:appsmarthome/ui/widgets/dados_card.dart';
import 'package:appsmarthome/ui/widgets/estado_botao.dart';
import 'package:appsmarthome/ui/widgets/controle_rgb.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late QuartoModel quarto;
  late QuartoService quartoService;
  late SalaModel sala;
  late SalaService salaService;
  late ParteExternaService parteExternaService;
  late ParteExternaModel parteExterna;
  double? _luminosidade;
  late BanheiroModel banheiro;
  late BanheiroService banheiroService;
  late CozinhaModel cozinha;
  late CozinhaService cozinhaService;
  late GaragemModel garagem;
  late GaragemService garagemService;

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

    // atualiza dados da parte externa em tempo real
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
            ? CircularProgressIndicator()
            : SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Bem vindo a sua casa inteligente",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "QUARTO",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder<String>(
                stream: quartoService.tempoRealTemperatura("quarto"),
                builder: (context, snapshot) {
                  final temperatura = snapshot.data ?? "Sem dados";
                  return DataCard(
                    titulo: "Temperatura",
                    valor: temperatura,
                    cor: Colors.orange,
                    isTemperature: true,
                  );
                },
              ),
              SizedBox(height: 20),
              StreamBuilder<String>(
                stream: quartoService.tempoRealUmidade("quarto"),
                builder: (context, snapshot) {
                  final umidade = snapshot.data ?? "Sem dados";
                  return DataCard(
                    titulo: "Umidade",
                    valor: umidade,
                    cor: Colors.blue,
                    isTemperature: false,
                  );
                },
              ),
              SizedBox(height: 40),
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
              SizedBox(height: 40),
              Text(
                "SALA",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              LightButton(
                estadoLampada: sala.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    sala.alterarEstadoLampada();
                  });
                  await salaService.atualizarEstadoLampada(sala);
                },
              ),
              SizedBox(height: 40),
              Text(
                "PARTE EXTERNA",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              LightButton(
                estadoLampada: parteExterna.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    parteExterna.alterarEstadoLampada();
                  });
                  await parteExternaService.atualizarEstadoLampada(parteExterna);
                },
              ),
              SizedBox(height: 20),
              Text(
                "Luminosidade da parte externa: ${_luminosidade != null ? _luminosidade!.toStringAsFixed(2) + '%' : "Carregando..."}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 40),
              Text(
                "BANHEIRO",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              LightButton(
                estadoLampada: banheiro.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    banheiro.alterarEstadoLampada();
                  });
                  await banheiroService.atualizarEstadoLampada(banheiro);
                },
              ),
              SizedBox(height: 40),
              Text(
                "COZINHA",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              LightButton(
                estadoLampada: cozinha.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    cozinha.alterarEstadoLampada();
                  });
                  await cozinhaService.atualizarEstadoLampada(cozinha);
                },
              ),
              SizedBox(height: 40),
              Text(
                "GARAGEM",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              LightButton(
                estadoLampada: garagem.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    garagem.alterarEstadoLampada();
                  });
                  await garagemService.atualizarEstadoLampada(garagem);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
