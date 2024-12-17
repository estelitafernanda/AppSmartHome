import 'package:appsmarthome/models/sala_comodo.dart';
import 'package:appsmarthome/service/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SalaService {
  final BuildContext context;

  SalaService(this.context);

  Future<SalaModel> carregarSala(String nome) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    final dados = await database.getAll(nome);

    return SalaModel.fromJson(nome, dados);
  }

  Future<void> atualizarEstadoLampada(SalaModel sala) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarEstadoLuz(sala.nome, sala.lampadaLigada);
  }
}