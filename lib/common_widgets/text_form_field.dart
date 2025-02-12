import 'package:flutter/material.dart';

class TextformField extends StatelessWidget {
  const TextformField({
    super.key,
    required this.initialValue,
    required this.inputHint,
    required this.onChange,
    required this.labelText,
  });

  final String initialValue;
  final String inputHint;
  final ValueChanged<String> onChange;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: inputHint,
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
      ),
      onChanged: onChange,
    );
  }
}
