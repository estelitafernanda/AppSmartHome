import 'package:appsmarthome/core/di/configuracao_providers.dart';
import 'package:appsmarthome/ui/pages/home_page.dart';
import 'package:appsmarthome/ui/pages/login_page.dart';
import 'package:appsmarthome/ui/widgets/auth_checker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConfigureProviders>(
      future: ConfigureProviders.createDependency(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Erro ao inicializar: ${snapshot.error}'),
              ),
            ),
          );
        }

        final data = snapshot.data!;

        return MultiProvider(
          providers: data.provider,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Minha Casa Inteligente',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const AuthChecker(),
          ),
        );
      },
    );
  }
}
