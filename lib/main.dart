
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

  try{
    if(Firebase.apps.isEmpty){
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform
      );
    }
  } catch (e){
    print('Firebase iniciado: $e');
  }

  final data = await ConfigureProviders.createDependency();

  runApp(MyApp(data: data));
}

class MyApp extends StatelessWidget {
  final ConfigureProviders data;

  const MyApp({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
      )
    );
  }
}
