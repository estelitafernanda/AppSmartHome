import 'package:appsmarthome/models/garagem_comodo.dart';
import 'package:appsmarthome/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GaragemService {
  final BuildContext context;

  GaragemService(this.context);

  Future<GaragemModel> carregarGaragem(String nome) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    final dados = await database.getAll(nome);

    return GaragemModel.fromJson(nome, dados);
  }

  Future<void> atualizarEstadoLampada(GaragemModel garagem) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarEstadoLuz(garagem.nome, garagem.lampadaLigada);
  }

  Future<void> atualizarEstadoMotor(GaragemModel garagem) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarEstadoMotor(garagem.nome, garagem.estadoMotor);
  }
}