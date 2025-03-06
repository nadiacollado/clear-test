import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/common_text_form_field.dart';
import '../../../../l10n/translate.dart';
import '../../navigation/app_router.dart';

class EditUserProfileWidget extends ConsumerStatefulWidget {
  const EditUserProfileWidget({
    super.key,
    required this.onUsernameChanged,
    required this.onSave,
    this.username,
    this.email,
  });
  final ValueChanged<String> onUsernameChanged;
  final String? username;
  final String? email;
  final VoidCallback onSave;

  @override
  ConsumerState<EditUserProfileWidget> createState() =>
      _EditUserProfileWidgetState();
}

class _EditUserProfileWidgetState extends ConsumerState<EditUserProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: <Widget>[
        TextButton(
          onPressed: () => context.goNamed(AppRoute.profile.name),
          child: Text(context.t.profile_go_to_profile),
        ),
        Text(context.t.profile_editUsername.toUpperCase()),
        CommonTextFormField(
          useController: true,
          labelText: widget.username ?? '',
          inputHint: context.t.profile_username,
          onChange: widget.onUsernameChanged,
        ),
        TextButton(
          onPressed: widget.onSave,
          child: Text(context.t.profile_save),
        ),
      ],
    );
  }
}
