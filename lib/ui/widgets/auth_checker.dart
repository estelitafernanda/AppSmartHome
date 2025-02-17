import 'package:appsmarthome/ui/pages/home_page.dart';
import 'package:appsmarthome/ui/pages/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) =>
        snapshot.hasData ? const HomePage() : const LoginOrRegisterPage(),
      ),
    );
  }
}