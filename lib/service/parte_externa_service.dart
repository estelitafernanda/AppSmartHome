import 'package:appsmarthome/models/parte_externa_comodo.dart';
import 'package:appsmarthome/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParteExternaService {
  final BuildContext context;

  ParteExternaService(this.context);

  Stream<ParteExternaModel> carregarParteExternaTempoReal(String nome) {
    final database = Provider.of<DatabaseService>(context, listen: false);

    return database.databaseReference.child('casa/$nome').onValue.map((event) {
      final dados = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return ParteExternaModel.fromJson(nome, Map<String, dynamic>.from(dados));
    });
  }

  Future<void> atualizarEstadoLampada(ParteExternaModel parteExterna) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarEstadoLuz(parteExterna.nome, parteExterna.lampadaLigada);
  }

  Stream<double> obterLuminosidadeTempoReal(String nome) {
    final database = Provider.of<DatabaseService>(context, listen: false);
    return database.databaseReference.child('casa/$nome/luminosidade').onValue.map((event) {
      final valor = event.snapshot.value;
      return valor is num ? valor.toDouble() : 0.0;
    });
  }
}