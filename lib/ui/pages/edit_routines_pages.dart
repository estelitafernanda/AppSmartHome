import 'package:appsmarthome/core/di/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRoutinesPage extends StatefulWidget {
  @override
  _EditRoutinesPageState createState() => _EditRoutinesPageState();
}

class _EditRoutinesPageState extends State<EditRoutinesPage> {
  late TextEditingController _homeLatitudeController;
  late TextEditingController _homeLongitudeController;
  late TextEditingController _radiusController;

  bool _apagarLuzQuarto = false;
  bool _ligarLuzSala = false;

  @override
  void initState() {
    super.initState();
    _homeLatitudeController = TextEditingController(text: "-5.7945");
    _homeLongitudeController = TextEditingController(text: "-35.211");
    _radiusController = TextEditingController(text: "0.001");
  }

  @override
  void dispose() {
    _homeLatitudeController.dispose();
    _homeLongitudeController.dispose();
    _radiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Rotinas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _homeLatitudeController,
              decoration: InputDecoration(labelText: "Latitude da Casa"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _homeLongitudeController,
              decoration: InputDecoration(labelText: "Longitude da Casa"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _radiusController,
              decoration: InputDecoration(labelText: "Raio (em graus)"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SwitchListTile(
              title: Text("Apagar Luz do Quarto ao Sair"),
              value: _apagarLuzQuarto,
              onChanged: (bool value) {
                setState(() {
                  _apagarLuzQuarto = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("Ligar Luz da Sala ao Chegar"),
              value: _ligarLuzSala,
              onChanged: (bool value) {
                setState(() {
                  _ligarLuzSala = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final locationProvider =
                    Provider.of<LocationProvider>(context, listen: false);
                locationProvider.saveRoutine(
                  apagarLuzQuarto: _apagarLuzQuarto,
                  ligarLuzSala: _ligarLuzSala,
                );
                Navigator.pop(context);
              },
              child: Text("Salvar Rotinas"),
            ),
          ],
        ),
      ),
    );
  }
}
