import 'package:appsmarthome/core/di/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRoutinesPage extends StatefulWidget {
  @override
  _EditRoutinesPageState createState() => _EditRoutinesPageState();
}

class _EditRoutinesPageState extends State<EditRoutinesPage> {

  bool _ligarLuzSala = false;
  bool _ligarLuzCozinha = false;
  bool _ligarLuzGaragem = false;

  // Valores RGB para o quarto
  int _vermelhoRgbQuarto = 0;
  int _verdeRgbQuarto = 0;
  int _azulRgbQuarto = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
            // Campos de Latitude, Longitude e Raio
            SizedBox(height: 20),
            // Switch para luzes
            SwitchListTile(
              title: Text("Ligar Luz da Sala ao Chegar"),
              value: _ligarLuzSala,
              onChanged: (bool value) {
                setState(() {
                  _ligarLuzSala = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("Ligar Luz da Cozinha ao Chegar"),
              value: _ligarLuzCozinha,
              onChanged: (bool value) {
                setState(() {
                  _ligarLuzCozinha = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("Ligar Luz da Garagem ao Chegar"),
              value: _ligarLuzGaragem,
              onChanged: (bool value) {
                setState(() {
                  _ligarLuzGaragem = value;
                });
              },
            ),
            SizedBox(height: 20),
            // Campos RGB para o Quarto
            TextField(
              decoration: InputDecoration(labelText: "Vermelho (0-255)"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _vermelhoRgbQuarto = int.tryParse(value) ?? 0;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Verde (0-255)"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _verdeRgbQuarto = int.tryParse(value) ?? 0;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Azul (0-255)"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _azulRgbQuarto = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final locationProvider = Provider.of<LocationProvider>(context, listen: false);
                locationProvider.saveRoutine(
                  ligarLuzSala: _ligarLuzSala,
                  ligarLuzCozinha: _ligarLuzCozinha,
                  ligarLuzGaragem: _ligarLuzGaragem,
                  vermelhoRgbQuarto: _vermelhoRgbQuarto,
                  verdeRgbQuarto: _verdeRgbQuarto,
                  azulRgbQuarto: _azulRgbQuarto,
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
