import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference _firebaseDatabase = FirebaseDatabase.instance.ref();

  DatabaseReference get databaseReference => _firebaseDatabase;

  Future<Map<String, dynamic>> getAll(String lugar) async {
    try {
      final snapshot = await _firebaseDatabase.child('casa/$lugar').get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        return Map<String, dynamic>.from(data);
      } else {
        return {};
      }
    } catch (e) {
      print('Erro ao obter dados do nó "$lugar": $e');
      return {};
    }
  }

  Future<void> atualizarEstadoLuz(String lugar, bool isOn) async {
    try {
      await _firebaseDatabase.child('casa/$lugar/lampada').set(isOn);
    } catch (e) {
      print('Erro ao atualizar o estado da luz: $e');
    }
  }

  Future<void> atualizarCoresRGB(String lugar, Map<String, int> rgbValues) async {
    try {
      await _firebaseDatabase.child('casa/$lugar/lampadaRGB').update(rgbValues);
    } catch (e) {
      print('Erro ao atualizar as cores RGB: $e');
    }
  }
}
