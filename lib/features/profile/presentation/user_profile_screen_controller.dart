import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/logger/logger.dart';
import '../../../core/user/data/user_repository.dart';
import '../domain/user_profile_form_state.dart';

part 'user_profile_screen_controller.g.dart';

@riverpod
class UserProfileScreenController extends _$UserProfileScreenController {
  late final UserRepository _userRepository;

  @override
  UserProfileFormState build() {
    _userRepository = ref.read(userRepositoryProvider);
    return const UserProfileFormState();
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username);
  }

  Future<void> saveProfile() async {
    final Map<String, dynamic> updates = state.getChangedFields();
    if (updates.isEmpty) return;

    try {
      await _userRepository.updateUserProfile(updates);
      logger.info(message: 'Profile updated successfully.');
    } catch (e, stackTrace) {
      logger.error(message: 'Error saving profile $e', stack: stackTrace);
    }
  }
}
