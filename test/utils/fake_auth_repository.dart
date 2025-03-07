import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_starter_kit/features/authentication/data/firebase_auth_repository.dart';
import 'package:flutter_starter_kit/features/authentication/domain/auth_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_auth_repository.g.dart';

@Riverpod(keepAlive: true)
class FakeAuthRepositoryProvider extends _$FakeAuthRepositoryProvider {
  @override
  FakeAuth build(AuthStatus authStatus) {
    return FakeAuth(authStatus);
  }
}

class FakeAuth implements AuthRepository {
  FakeAuth(this._authStatus) {
    _authStateController = StreamController<User?>.broadcast();
    _authStateController.add(_currentUser);
  }

  User? _currentUser;
  AuthStatus _authStatus;
  late StreamController<User?> _authStateController;

  void setCurrentUser(User? user) {
    _currentUser = user;
    if (user != null) {
      _authStatus = AuthStatus.authenticated;
    } else {
      _authStatus = AuthStatus.unauthenticated;
    }
    _authStateController.add(_currentUser);
  }

  set authStatus(AuthStatus status) {
    _authStatus = status;
  }

  // ignore: unnecessary_getters_setters
  AuthStatus get authStatus => _authStatus;

  @override
  Stream<User?> authStateChanges() {
    return _authStateController.stream;
  }

  @override
  User? get currentUser => _currentUser;

  @override
  Future<AuthStatus> createUser(String email, String password) async {
    return _authStatus;
  }

  @override
  Future<AuthStatus> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return _authStatus;
  }

  @override
  Future<void> signOut() async {
    setCurrentUser(null);
  }

  @override
  Future<AuthStatus> resetPassword(String email) async {
    return _authStatus;
  }

  @override
  Future<AuthStatus> isEmailVerified(User user) async {
    return _authStatus;
  }

  @override
  Future<AuthStatus> sendVerificationEmail() async {
    return _authStatus;
  }

  void dispose() {
    _authStateController.close();
  }
}
