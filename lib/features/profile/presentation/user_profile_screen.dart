import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/user/data/user_repository.dart';
import '../../../core/user/domain/user.dart';

import 'user_profile_screen_controller.dart';
import 'user_profile_widget.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserProfileScreenController controller =
        ref.read(userProfileScreenControllerProvider.notifier);
    final AsyncValue<User?> userAsyncValue = ref.watch(userStreamProvider);

    return Center(
      child: userAsyncValue.when(
        data: (User? user) => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: UserProfileWidget(
              email: user?.email,
              username: user?.username,
              onUsernameChanged: controller.updateUsername,
              onSave: controller.saveProfile,
            ),
          ),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (Object error, StackTrace stackTrace) => Text('Error: $error'),
      ),
    );
  }
}
