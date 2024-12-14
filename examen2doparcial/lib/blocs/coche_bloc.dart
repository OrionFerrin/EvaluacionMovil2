import 'dart:async';
import '../models/coche.dart';
import '../services/firebase_service.dart';

class CocheBloc {
  final FirebaseService _firebaseService = FirebaseService();
  final _cocheController = StreamController<List<Coche>>.broadcast();

  Stream<List<Coche>> get cocheStream => _cocheController.stream;

  void getCocheList() {
    _firebaseService.getCochesStream().listen((coches) {
      _cocheController.add(coches);
    });
  }

  Future<void> addCoche(Coche coche) async {
    await _firebaseService.addCoche(coche);
  }

  String? getCurrentUserEmail() {
    return _firebaseService.getCurrentUserEmail();
  }

  void dispose() {
    _cocheController.close();
  }
}

