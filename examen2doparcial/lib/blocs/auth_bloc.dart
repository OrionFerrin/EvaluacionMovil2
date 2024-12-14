import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';

class AuthBloc {
  final FirebaseService _firebaseService = FirebaseService();
  final _authController = StreamController<User?>.broadcast();

  Stream<User?> get authStream => _authController.stream;

  void checkAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _authController.add(user);
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseService.signIn(email, password);
    } catch (e) {
      _authController.addError(e);
    }
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
  }

  void dispose() {
    _authController.close();
  }
}

