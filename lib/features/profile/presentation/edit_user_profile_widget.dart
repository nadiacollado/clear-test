import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common_widgets/common_text_form_field.dart';
import '../../../../l10n/translate.dart';

class EditUserProfileWidget extends ConsumerStatefulWidget {
  const EditUserProfileWidget({
    super.key,
    required this.onUsernameChanged,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onPronounsChanged,
    required this.onAgeChanged,
    required this.onLocationChanged,
    required this.onBioChanged,
    required this.disableSaveButtonExperiment,
    required this.onSave,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.age,
    this.location,
    this.pronouns,
    this.bio,
  });

  final ValueChanged<String> onUsernameChanged;
  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onLastNameChanged;
  final ValueChanged<String> onPronounsChanged;
  final ValueChanged<String> onAgeChanged;
  final ValueChanged<String> onLocationChanged;
  final ValueChanged<String> onBioChanged;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? age;
  final String? location;
  final String? pronouns;
  final String? bio;
  final VoidCallback onSave;
  final bool disableSaveButtonExperiment;

  @override
  ConsumerState<EditUserProfileWidget> createState() =>
      _EditUserProfileWidgetState();
}

class _EditUserProfileWidgetState extends ConsumerState<EditUserProfileWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!kReleaseMode && Firebase.apps.isNotEmpty) {
        // For experiment validation purposes only
        final String token = await FirebaseInstallations.instance.getToken();

        // ignore: avoid_print
        print('Firebase installation auth token:\n$token');
      }
    });
  }

  Widget saveButton() {
    void saveOnPressed() {
      if (_formKey.currentState?.validate() ?? false) {
        widget.onSave();
      }
    }

    if (!widget.disableSaveButtonExperiment) {
      return ElevatedButton(
        onPressed: saveOnPressed,
        child: Text(context.t.profile_save),
      );
    }

    return ElevatedButton(
      onPressed: isChanged ? saveOnPressed : null,
      child: Text(context.t.profile_save),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildField(
              context.t.profile_editUsername,
              context.t.profile_username,
              widget.onUsernameChanged,
              widget.username,
            ),
            _buildField(
              context.t.profile_editFirstName,
              context.t.profile_firstName,
              widget.onFirstNameChanged,
              widget.firstName,
            ),
            _buildField(
              context.t.profile_editLastName,
              context.t.profile_lastName,
              widget.onLastNameChanged,
              widget.lastName,
            ),
            _buildField(
              context.t.profile_editPronouns,
              context.t.profile_pronouns,
              widget.onPronounsChanged,
              widget.pronouns,
            ),
            _buildField(
              context.t.profile_editAge,
              context.t.profile_age,
              widget.onAgeChanged,
              widget.age,
              validator: _validateAge,
            ),
            _buildField(
              context.t.profile_editLocation,
              context.t.profile_location,
              widget.onLocationChanged,
              widget.location,
            ),
            _buildField(
              context.t.profile_editBio,
              context.t.profile_bio,
              widget.onBioChanged,
              widget.bio,
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: saveButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint,
    ValueChanged<String> onChanged,
    String? initialValue, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    void wrappedOnChanged(String param) {
      if (!isChanged) {
        setState(() {
          isChanged = true;
        });
      }
      onChanged(param);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        CommonTextFormField(
          useController: true,
          inputHint: hint,
          onChange: wrappedOnChanged,
          initialValue: initialValue,
          maxLines: maxLines,
          validator: validator,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else {
      final int? age = int.tryParse(value);
      if (age == null || age < 0 || age > 120) {
        return context.t.profile_ageError;
      }
    }
    return null;
  }
}
