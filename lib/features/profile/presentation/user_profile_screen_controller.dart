import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/user_repository.dart';
import '../domain/user_profile_form_state.dart';

part 'user_profile_screen_controller.g.dart';

@riverpod
class UserProfileScreenController extends _$UserProfileScreenController {
  late final UserRepository _userRepository;

  @override
  UserProfileFormState build() {
    _userRepository = ref.read(userRepositoryProvider);
    _loadUserData();
    return const UserProfileFormState();
  }

  Future<void> _loadUserData() async {
    final String? username = await _userRepository.getCurrentUsername();
    if (username != null) {
      state = state.copyWith(username: username);
    }
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username);
  }

  Future<void> save() async {
    await _userRepository.updateUsername(state.username);
  }
}
