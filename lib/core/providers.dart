
import 'package:appsmarthome/service/database_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


class ConfigureProviders {

  final List<SingleChildWidget> provider;

  ConfigureProviders({required this.provider});

  static Future<ConfigureProviders> createDependency() async {
    final database = DatabaseService();


    return ConfigureProviders(provider: [
      Provider<DatabaseService>.value(value:database),
    ]);
  }

}
