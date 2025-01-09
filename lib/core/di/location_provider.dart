import 'package:appsmarthome/models/banheiro_comodo.dart';
import 'package:appsmarthome/models/cozinha_comodo.dart';
import 'package:appsmarthome/models/garagem_comodo.dart';
import 'package:appsmarthome/models/quarto_comodo.dart';
import 'package:appsmarthome/models/sala_comodo.dart';
import 'package:appsmarthome/service/banheiro_service.dart';
import 'package:appsmarthome/service/cozinha_service.dart';
import 'package:appsmarthome/service/garagem_service.dart';
import 'package:appsmarthome/service/parte_externa_service.dart';
import 'package:appsmarthome/service/quarto_service.dart';
import 'package:appsmarthome/service/sala_service.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/parte_externa_comodo.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  bool _isAtHome = false;

  // Controle de estados para rotinas
  bool ligarLuzSala = false;
  bool ligarLuzCozinha = false;
  bool ligarLuzGaragem = false;
  bool ligarLuzBanheiro = false;
  bool ligarLuzParteExterna = false;

  // Serviços
  final QuartoService quartoService;
  final SalaService salaService;
  final ParteExternaService parteExternaService;
  final BanheiroService banheiroService;
  final CozinhaService cozinhaService;
  final GaragemService garagemService;

  LocationProvider({
    required this.quartoService,
    required this.salaService,
    required this.parteExternaService,
    required this.banheiroService,
    required this.cozinhaService,
    required this.garagemService,
  });

  Position? get currentPosition => _currentPosition;
  bool get isAtHome => _isAtHome;

  Future<void> updateLocation({
    required bool ligarLuzSala,
    required bool ligarLuzCozinha,
    required bool ligarLuzGaragem,
    required bool ligarLuzBanheiro,
    required bool ligarLuzParteExterna,
    required int vermelhoRgbQuarto,
    required int verdeRgbQuarto,
    required int azulRgbQuarto,
  }) async {
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    notifyListeners();

    _checkAndUpdateRoutines(
      _currentPosition!,
      ligarLuzSala: ligarLuzSala,
      ligarLuzCozinha: ligarLuzCozinha,
      ligarLuzGaragem: ligarLuzGaragem,
      ligarLuzBanheiro: ligarLuzBanheiro,
      ligarLuzParteExterna: ligarLuzParteExterna,
      vermelhoRgbQuarto: vermelhoRgbQuarto,
      verdeRgbQuarto: verdeRgbQuarto,
      azulRgbQuarto: azulRgbQuarto,
    );
  }


  void _checkAndUpdateRoutines(
      Position position, {
        required bool ligarLuzSala,
        required bool ligarLuzCozinha,
        required bool ligarLuzGaragem,
        required bool ligarLuzBanheiro,
        required bool ligarLuzParteExterna,
        required int vermelhoRgbQuarto,
        required int verdeRgbQuarto,
        required int azulRgbQuarto,
      }) {
    bool isAtHome = _checkIfAtHome(position);

    _isAtHome = isAtHome;

    if (isAtHome) {
      // Rotinas quando o usuário está em casa
      if (ligarLuzSala) {
        salaService.atualizarEstadoLampada(
          SalaModel(nome: "sala", lampadaLigada: true),
        );
      }
      if (ligarLuzCozinha) {
        cozinhaService.atualizarEstadoLampada(
          CozinhaModel(nome: "cozinha", lampadaLigada: true),
        );
      }
      if (ligarLuzGaragem) {
        garagemService.atualizarEstadoLampada(
          GaragemModel(nome: "garagem", lampadaLigada: true),
        );
      }
      if (ligarLuzBanheiro) {
        banheiroService.atualizarEstadoLampada(
          BanheiroModel(nome: "banheiro", lampadaLigada: true),
        );
      }
      if (ligarLuzParteExterna) {
        parteExternaService.atualizarEstadoLampada(
          ParteExternaModel(nome: "parteExterna", lampadaLigada: true),
        );
      }
      // Atualiza as cores RGB do quarto
      quartoService.atualizarCoresRGB(
        QuartoModel(
          nome: "lampadaRGB",
          vermelho_rgb: vermelhoRgbQuarto,
          verde_rgb: verdeRgbQuarto,
          azul_rgb: azulRgbQuarto,
        ),
      );


    } else {
      // Rotinas quando o usuário não está em casa
      salaService.atualizarEstadoLampada(
        SalaModel(nome: "sala", lampadaLigada: false),
      );
      cozinhaService.atualizarEstadoLampada(
        CozinhaModel(nome: "cozinha", lampadaLigada: false),
      );
      garagemService.atualizarEstadoLampada(
        GaragemModel(nome: "garagem", lampadaLigada: false),
      );
      banheiroService.atualizarEstadoLampada(
        BanheiroModel(nome: "banheiro", lampadaLigada: false),
      );
      parteExternaService.atualizarEstadoLampada(
        ParteExternaModel(nome: "parteExterna", lampadaLigada: false),
      );
      quartoService.atualizarCoresRGB(QuartoModel(nome: "lampadaRGB", verde_rgb: 0, vermelho_rgb: 0, azul_rgb: 0));
    }

    notifyListeners();
  }


  // Método para verificar se está em casa (dentro de um raio fixo)
  bool _checkIfAtHome(Position position) {
    const homeLatitude = -5.7945;
    const homeLongitude = -35.211;
    const radius = 0.001; // em graus

    return (position.latitude - homeLatitude).abs() < radius &&
           (position.longitude - homeLongitude).abs() < radius;
  }
}
