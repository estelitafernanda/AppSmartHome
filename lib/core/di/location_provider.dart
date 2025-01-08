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
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  bool _isAtHome = false;

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

  Future<void> updateLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    notifyListeners();
    // Verifique se está em casa (exemplo: posição fixa da casa)
    _isAtHome = _checkIfAtHome(_currentPosition!);
    notifyListeners();
    _updateRoutines();
  }

  bool _checkIfAtHome(Position position) {
    // Adicione a lógica para determinar se está em casa
    // Exemplo: verificar se está dentro de um raio de coordenadas fixas
    const homeLatitude = -5.7945;
    const homeLongitude = -35.211;
    const radius = 0.001; // em graus

    return (position.latitude - homeLatitude).abs() < radius &&
           (position.longitude - homeLongitude).abs() < radius;
  }

  void _updateRoutines() {
    if (_isAtHome) {
      // Executar rotinas de "estar em casa"
      quartoService.atualizarEstadoLampada(QuartoModel(nome: "Quarto", lampadaLigada: true));
      salaService.atualizarEstadoLampada(SalaModel(nome: "Sala", lampadaLigada: true, luminosidade: 0, presencaDetectada: false));
      parteExternaService.atualizarEstadoLampada(ParteExternaModel(nome: "Parte Externa", lampadaLigada: true, luminosidade: 0));
      banheiroService.atualizarEstadoLampada(BanheiroModel(nome: "Banheiro", lampadaLigada: true));
      cozinhaService.atualizarEstadoLampada(CozinhaModel(nome: "Cozinha", lampadaLigada: true, luminosidade: 0));
      garagemService.atualizarEstadoLampada(GaragemModel(nome: "Garagem", lampadaLigada: true));
    } else {
      // Executar rotinas de "não estar em casa"
      quartoService.atualizarEstadoLampada(QuartoModel(nome: "Quarto", lampadaLigada: false));
      salaService.atualizarEstadoLampada(SalaModel(nome: "Sala", lampadaLigada: false, luminosidade: 0, presencaDetectada: false));
      parteExternaService.atualizarEstadoLampada(ParteExternaModel(nome: "Parte Externa", lampadaLigada: false, luminosidade: 0));
      banheiroService.atualizarEstadoLampada(BanheiroModel(nome: "Banheiro", lampadaLigada: false));
      cozinhaService.atualizarEstadoLampada(CozinhaModel(nome: "Cozinha", lampadaLigada: false, luminosidade: 0));
      garagemService.atualizarEstadoLampada(GaragemModel(nome: "Garagem", lampadaLigada: false));
    }
  }
}
