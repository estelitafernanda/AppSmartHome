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
import 'package:appsmarthome/ui/widgets/comodo_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/*
class _HomePageState extends State<HomePage> {
  late QuartoModel quarto;
  late QuartoService quartoService;
  //late CozinhaModel cozinha;
  //late CozinhaService cozinhaService;
  //late SalaModel sala;
  //late SalaService salaService;
  bool _estaCarregando = true;

  @override
  void initState() {
    super.initState();
   quartoService = QuartoService(context);
   // cozinhaService = CozinhaService(context);
    //salaService = SalaService(context);
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final quartoCarregado = await quartoService.carregarQuarto("quarto");
      //final cozinhaCarregada = await cozinhaService.carregarCozinha("cozinha");
      //final salaCarregada = await salaService.carregarSala("sala");

      setState(() {
        quarto = quartoCarregado;
       // cozinha = cozinhaCarregada;
        //sala = salaCarregada;
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
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Bem vindo a sua casa inteligente",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
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

              const SizedBox(height: 20),
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
              /*
              SizedBox(height: 40),
              LightButton(
                estadoLampada: cozinha.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    cozinha.alterarEstadoLampada();
                  });
                  await cozinhaService.atualizarEstadoLampada(cozinha);
                },
              ),*/

              /*
              SizedBox(height: 40),
              LightButton(
                estadoLampada: sala.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    sala.alterarEstadoLampada();
                  });
                  await salaService.atualizarEstadoLampada(sala);
                },
              ),
              */
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
            ],
          ),
        ),
      ),
    );
  }
}
*/

/*
class _HomePageState extends State<HomePage> {
  late BanheiroModel banheiro;
  late BanheiroService banheiroService;
  bool _estaCarregando = true;

  @override
  void initState() {
    super.initState();
    banheiroService = BanheiroService(context);
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {

      final banheiroCarregado = await banheiroService.carregarBanheiro("banheiro");

      setState(() {
        banheiro = banheiroCarregado;
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

              SizedBox(height: 40),
              Text("BANHEIRO"),
              LightButton(
                estadoLampada: banheiro.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    banheiro.alterarEstadoLampada();
                  });
                  await banheiroService.atualizarEstadoLampada(banheiro);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
*/


/*
class _HomePageState extends State<HomePage> {
  late CozinhaModel cozinha;
  late CozinhaService cozinhaService;
  bool _estaCarregando = true;

  @override
  void initState() {
    super.initState();
    cozinhaService = CozinhaService(context);
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {

      final cozinhaCarregada = await cozinhaService.carregarCozinha("cozinha");

      setState(() {
        cozinha = cozinhaCarregada;
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

              SizedBox(height: 40),
              Text("COZINHA"),
              LightButton(
                estadoLampada: cozinha.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    cozinha.alterarEstadoLampada();
                  });
                  await cozinhaService.atualizarEstadoLampada(cozinha);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
*/

/*
class _HomePageState extends State<HomePage> {
  late GaragemModel garagem;
  late GaragemService garagemService;
  bool _estaCarregando = true;

  @override
  void initState() {
    super.initState();
    garagemService = GaragemService(context);
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {

      final garagemCarregada = await garagemService.carregarGaragem("garagem");

      setState(() {
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

              SizedBox(height: 40),
              Text("GARAGEM"),
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
*/


class _HomePageState extends State<HomePage> {
  late ParteExternaService parteExternaService;
  ParteExternaModel? parteExterna;
  double? _luminosidade;
  late QuartoModel quarto;
  late QuartoService quartoService;
  late CozinhaModel cozinha;
  late CozinhaService cozinhaService;
  late SalaModel sala;
  late SalaService salaService;
  bool _estaCarregando = true;

  @override
  void initState() {
    super.initState();
    quartoService = QuartoService(context);
    cozinhaService = CozinhaService(context);
    salaService = SalaService(context);
    parteExternaService = ParteExternaService(context);

    // atualiza parte externa em tempo real
    parteExternaService.carregarParteExternaTempoReal("parteExterna").listen((dados) {
      setState(() {
        parteExterna = dados;
      });
    });

    // atualiza luminosidade em tempo real
    parteExternaService.obterLuminosidadeTempoReal("parteExterna").listen((luminosidade) {
      setState(() {
        _luminosidade = luminosidade;
      });
    });

    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final quartoCarregado = await quartoService.carregarQuarto("quarto");
      final cozinhaCarregada = await cozinhaService.carregarCozinha("cozinha");
      final salaCarregada = await salaService.carregarSala("sala");

      setState(() {
        quarto = quartoCarregado;
        cozinha = cozinhaCarregada;
        sala = salaCarregada;
        _estaCarregando = false;
      });
    } catch (e) {
      print('Erro ao carregar dados: $e');
      setState(() {
        _estaCarregando = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar dados, tente novamente.'))
      );
    }
  }

  // Método genérico para alterar o estado das lâmpadas
  Future<void> _alterarEstadoLampada(bool estadoLampada, Function atualizarEstado) async {
    setState(() {
      estadoLampada = !estadoLampada; // Alterna o estado da lâmpada
    });
    await atualizarEstado(estadoLampada);
  }

  void _atualizarCorRGB(int valor, String cor) {
    setState(() {
      switch (cor) {
        case 'red':
          quarto.atualizarRGB(valor, quarto.verde_rgb, quarto.azul_rgb);
          break;
        case 'green':
          quarto.atualizarRGB(quarto.vermelho_rgb, valor, quarto.azul_rgb);
          break;
        case 'blue':
          quarto.atualizarRGB(quarto.vermelho_rgb, quarto.verde_rgb, valor);
          break;
      }
    });
    quartoService.atualizarCoresRGB(quarto);
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
      body: _estaCarregando
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/smarthome.png', 
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Bem vindo a sua casa inteligente",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text("PARTE EXTERNA"),
                  LightButton(
                    estadoLampada: parteExterna!.lampadaLigada,
                    onPressed: () async {
                      await _alterarEstadoLampada(parteExterna!.lampadaLigada, parteExternaService.atualizarEstadoLampada);
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Luminosidade Atual da Parte Externa: ${_luminosidade != null ? _luminosidade!.toStringAsFixed(2) + '%' : "Carregando..."}",
                    style: TextStyle(fontSize: 18),
                  ),
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
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 40),
                  LightButton(
                    estadoLampada: cozinha.lampadaLigada,
                    onPressed: () async {
                      await _alterarEstadoLampada(cozinha.lampadaLigada, cozinhaService.atualizarEstadoLampada);
                    },
                  ),
                  const SizedBox(height: 40),
                  LightButton(
                    estadoLampada: sala.lampadaLigada,
                    onPressed: () async {
                      await _alterarEstadoLampada(sala.lampadaLigada, salaService.atualizarEstadoLampada);
                    },
                  ),
                  const SizedBox(height: 40),
                  RGBControl(
                    vermelho: quarto.vermelho_rgb,
                    verde: quarto.verde_rgb,
                    azul: quarto.azul_rgb,
                    onRedChanged: (value) => _atualizarCorRGB(value, 'red'),
                    onGreenChanged: (value) => _atualizarCorRGB(value, 'green'),
                    onBlueChanged: (value) => _atualizarCorRGB(value, 'blue'),
                  ),
                ],
              ),
            ),
    );
  }
}






/*
class _HomePageState extends State<HomePage> {
  late SalaModel sala;
  late SalaService salaService;
  bool _estaCarregando = true;

  @override
  void initState() {
    super.initState();
    salaService = SalaService(context);
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {

      final salaCarregada = await salaService.carregarSala("sala");

      setState(() {
        sala = salaCarregada;
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

              SizedBox(height: 40),
              Text("SALA"),
              LightButton(
                estadoLampada: sala.lampadaLigada,
                onPressed: () async {
                  setState(() {
                    sala.alterarEstadoLampada();
                  });
                  await salaService.atualizarEstadoLampada(sala);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
 */