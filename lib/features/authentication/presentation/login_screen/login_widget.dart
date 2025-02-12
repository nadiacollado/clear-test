import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/primary_button.dart';

class LoginWidget extends ConsumerStatefulWidget {
  final void onLogin;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onCreateAccount;

  const LoginWidget(
      {super.key,
      required this.onLogin,
      required this.onEmailChanged,
      required this.onPasswordChanged,
      required this.onCreateAccount});
  @override
  ConsumerState<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Please enter your username',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(),
          ),
          onChanged: widget.onEmailChanged,
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Please enter your password',
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
          ),
          obscureText: true,
          onChanged: widget.onPasswordChanged,
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          text: "Login",
          onPressed: () => widget.onLogin,
          type: ButtonType.primary,
          isFullWidth: true,
        ),
        const SizedBox(height: 16), // Space between buttons
        PrimaryButton(
          text: "Create an Account",
          onPressed: widget.onCreateAccount,
          type: ButtonType.transparent,
          isFullWidth: true,
        ),
      ],
    );
  }
}
