import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/coche.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<List<Coche>> getCochesStream() {
    return _firestore.collection('coche').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Coche.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> addCoche(Coche coche) async {
    await _firestore.collection('coche').add(coche.toMap());
  }

  String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }
}

