import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/translate.dart';

class AuthScaffold extends ConsumerWidget {
  const AuthScaffold(
    this.body, {
    super.key,
    this.title,
  });

  final String? title;
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? context.t.global_title),
      ),
      body: body,
    );
  }
}
