import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? usuario;

  AuthProvider() {
    _authService.authState.listen(
      (user) {
        usuario = user;
        notifyListeners();
      },
    );
  }

  bool get logado => usuario != null;

  Future<void> login(
    String email,
    String senha,
  ) async {
    await _authService.login(
      email: email,
      senha: senha,
    );
  }

  Future<UserCredential> cadastrar(
    String email,
    String senha,
  ) async {
    return await _authService.cadastrar(
      email: email,
      senha: senha,
    );
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
