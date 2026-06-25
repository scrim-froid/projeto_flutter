import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  User? get usuarioAtual =>
      _auth.currentUser;

  Stream<User?> get authState =>
      _auth.authStateChanges();

  Future<UserCredential> cadastrar({
    required String email,
    required String senha,
  }) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<UserCredential> login({
    required String email,
    required String senha,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<void> logout() async {
  debugPrint('ANTES SIGNOUT');
  
  await _auth.signOut();

  debugPrint(
    'DEPOIS SIGNOUT: ${_auth.currentUser}',
  );
}
}