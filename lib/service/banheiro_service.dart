import 'package:appsmarthome/models/banheiro_comodo.dart';
import 'package:appsmarthome/models/cozinha_comodo.dart';
import 'package:appsmarthome/service/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BanheiroService {
  final BuildContext context;

  BanheiroService(this.context);

  Future<BanheiroModel> carregarBanheiro(String nome) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    final dados = await database.getAll(nome);

    return BanheiroModel.fromJson(nome, dados);
  }

  Future<void> atualizarEstadoLampada(BanheiroModel banheiro) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await database.atualizarEstadoLuz(banheiro.nome, banheiro.lampadaLigada);
  }
}