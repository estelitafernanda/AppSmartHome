import 'package:appsmarthome/models/cozinha_comodo.dart';
import 'package:appsmarthome/service/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CozinhaService {
  final BuildContext context;

  CozinhaService(this.context);

  Future<CozinhaModel> carregarCozinha(String nome) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    final dados = await database.getAll(nome);

    return CozinhaModel.fromJson(nome, dados);
  }

  Future<void> atualizarEstadoLampada(CozinhaModel cozinha) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarEstadoLuz(cozinha.nome, cozinha.lampadaLigada);
  }
}