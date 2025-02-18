import 'package:flutter_starter_kit/features/authentication/data/firebase_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_screen_controller.g.dart';

@riverpod
class LoginScreenController extends _$LoginScreenController {
  @override
  FutureOr<void> build() {
    // no op
  }

  String _email = '';
  String _password = '';

  bool get isLoginDisabled =>
      _email.isEmpty || _password.isEmpty || _password.length < 6;

  void updateEmail(String email) {
    _email = email;
  }

  void updatePassword(String password) {
    _password = password;
  }

  Future<AsyncValue<void>> signInWithEmailPassword() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      await authRepository.signInWithEmailPassword(_email, _password);
    });

    state = result;

    return result;
  }
}
