import 'package:firebase_auth/firebase_auth.dart';

import 'auth_status.dart';

class AuthState {
  const AuthState({required this.status, this.user});

  final AuthStatus status;
  final User? user;

  AuthState copyWith({required AuthStatus status, User? user}) {
    return AuthState(status: status, user: user);
  }
}
