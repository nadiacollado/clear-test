import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/common_widgets/primary_button.dart';
import 'package:flutter_starter_kit/features/authentication/presentation/login_screen/login_widget.dart';
import 'package:flutter_starter_kit/features/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400,
              maxHeight: 600,
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LoginWidget(
                  onLogin: (value) => {},
                  onEmailChanged: (value) => {},
                  onPasswordChanged: (value) => {},
                  onCreateAccount: () => context.goNamed(AppRoute.signUp.name),
                ))));
  }
}
