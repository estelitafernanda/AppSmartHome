import 'package:appsmarthome/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appsmarthome/model/quarto.dart';

class QuartoService {
  final BuildContext context;

  QuartoService(this.context);

  Future<QuartoModel> carregarQuarto(String nomeQuarto) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    final dados = await database.getAll(nomeQuarto);

    return QuartoModel.fromJson(nomeQuarto, dados);
  }

  // metodo para escutar em tempo real as todas as mudanças do quarto
  Stream<QuartoModel> escutarQuarto(String nomeQuarto) {
    final database = Provider.of<DatabaseService>(context, listen: false);

    return database.databaseReference
        .child('casa/$nomeQuarto')
        .onValue
        .map((event) {
      final dados = Map<String, dynamic>.from(event.snapshot.value as Map);
      return QuartoModel.fromJson(nomeQuarto, dados);
    });
  }

  Stream<String> tempoRealTemperatura(String nomeQuarto) {
    final database = Provider.of<DatabaseService>(context, listen: false);

    return database.databaseReference
        .child('casa/$nomeQuarto/temperatura')
        .onValue
        .map((event) {
      return event.snapshot.value?.toString() ?? "Sem dados";
    });
  }

  Stream<String> tempoRealUmidade(String nomeQuarto) {
    final database = Provider.of<DatabaseService>(context, listen: false);

    return database.databaseReference
        .child('casa/$nomeQuarto/umidade')
        .onValue
        .map((event) {
      return event.snapshot.value?.toString() ?? "Sem dados";
    });
  }

  Future<void> atualizarEstadoLampada(QuartoModel quarto) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarEstadoLuz(quarto.nome, quarto.estadoLampada);
  }

  Future<void> atualizarEstadoAr(QuartoModel quarto) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.alterarEstadoAr(quarto.nome, quarto.estadoArCondicionado);
  }

  Future<void> atualizarTemperaturaAr(QuartoModel quarto) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarTemperaturaAr(quarto.nome, quarto.temperaturaArCondicionado);
  }


  Future<void> atualizarCoresRGB(QuartoModel quarto) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarCoresRGB(quarto.nome, {
      'R': quarto.vermelho_rgb,
      'G': quarto.verde_rgb,
      'B': quarto.azul_rgb,
    });
  }
}