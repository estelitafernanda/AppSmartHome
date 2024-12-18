

import 'package:appsmarthome/model/cozinha.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database_service.dart';

class CozinhaService{

  final BuildContext context;

  CozinhaService(this.context);

  Future<Cozinha> carregarCozinha(String nomeComodo) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    final dados = await database.getAll(nomeComodo);

    return Cozinha.fromJson(dados);
  }



  Future<void> atualizarEstadoLampada(Cozinha cozi) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarEstadoLuz("cozinha",cozi.estadoLampada);
  }
}
