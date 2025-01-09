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
import 'package:appsmarthome/ui/widgets/card_banheiro.dart';
import 'package:appsmarthome/ui/widgets/card_cozinha.dart';
import 'package:appsmarthome/ui/widgets/card_garagem.dart';
import 'package:appsmarthome/ui/widgets/card_parteexterna.dart';
import 'package:appsmarthome/ui/widgets/card_quarto.dart';
import 'package:appsmarthome/ui/widgets/card_sala.dart';
import 'package:appsmarthome/ui/widgets/custom_button.dart';
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
  late GaragemModel garagem = GaragemModel(nome: "Garagem", lampadaLigada: false, estadoMotor: false);
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
          "",
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
                    const SizedBox(height: 10),
                    const Text(
                      "Bem-vindo à sua casa inteligente",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    QuartoCard(),

                    const SizedBox(height: 40),

                    // SALA - Dados
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: 
                          SalaCard(),
                        ),
                        Expanded(child: 
                          CozinhaCard(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // PARTE EXTERNA - Dados
                    ParteExternaCard(),

                    const SizedBox(height: 40),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: 
                          GaragemCard(),
                        ),
                        Expanded(
                          child: 
                          BanheiroCard(),
                        ),
                      ],
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
}
