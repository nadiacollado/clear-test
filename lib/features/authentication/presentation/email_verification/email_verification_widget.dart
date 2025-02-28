import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/common_button.dart';

class EmailVerificationWidget extends ConsumerWidget {
  const EmailVerificationWidget({super.key, required this.onSendEmail});

  final Future<void> Function() onSendEmail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: <Widget>[
          const Icon(
            Icons.email,
            size: 75,
            color: Colors.blue,
          ),
          const Text(
            'Please verify your email address. A confirmation link has been sent to your email.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Having Trouble?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              CommonButton(
                type: ButtonType.transparent,
                text: 'Resend Email',
                onPressed: () => onSendEmail(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
