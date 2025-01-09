import 'package:appsmarthome/core/di/location_provider.dart';
import 'package:appsmarthome/service/auth_service.dart';
import 'package:appsmarthome/service/banheiro_service.dart';
import 'package:appsmarthome/service/cozinha_service.dart';
import 'package:appsmarthome/service/database_service.dart';
import 'package:appsmarthome/service/garagem_service.dart';
import 'package:appsmarthome/service/parte_externa_service.dart';
import 'package:appsmarthome/service/quarto_service.dart';
import 'package:appsmarthome/service/sala_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ConfigureProviders {
  final List<SingleChildWidget> provider;

  ConfigureProviders({required this.provider});

  static Future<ConfigureProviders> createDependency(BuildContext context) async {
    final database = DatabaseService();
    final authService = AuthService();
    final quartoService = QuartoService(context);
    final salaService = SalaService(context);
    final parteExternaService = ParteExternaService(context);
    final banheiroService = BanheiroService(context);
    final cozinhaService = CozinhaService(context);
    final garagemService = GaragemService(context);

    final rotina = LocationProvider(
      quartoService: quartoService,
      salaService: salaService,
      parteExternaService: parteExternaService,
      banheiroService: banheiroService,
      cozinhaService: cozinhaService,
      garagemService: garagemService,
    );

    return ConfigureProviders(provider: [
      Provider<DatabaseService>.value(value: database),
      Provider<AuthService>.value(value: authService),
      ChangeNotifierProvider<LocationProvider>.value(value: rotina), // Alterado para ChangeNotifierProvider
    ]);
  }
}
