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

  // Controle de estados para rotinas
  bool ligarLuzQuarto = false;
  bool ligarLuzSala = false;

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
    _checkAndUpdateRoutines(_currentPosition!);
  }

  // Método para salvar as preferências de rotinas
  void saveRoutine({
    required bool luzQuarto,
    required bool luzSala,
  }) {
    this.ligarLuzQuarto = luzQuarto;
    this.ligarLuzSala = luzSala;
    notifyListeners();
  }

  // Verifica se o usuário está em casa e dispara rotinas
  void _checkAndUpdateRoutines(Position position) {
    bool isAtHome = _checkIfAtHome(position);
    if (isAtHome) {
      _isAtHome = true;
      if (ligarLuzSala) {
        salaService.atualizarEstadoLampada(SalaModel(nome: "Sala", lampadaLigada: true));
      }
    } else {
      _isAtHome = false;
      if (luzQuarto) {
        quartoService.atualizarCoresRGB(QuartoModel(nome: "Quarto", azul_rgb: 0, verde_rgb: 0, vermelho_rgb: 0));
      }
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
