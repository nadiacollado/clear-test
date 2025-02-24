import 'package:flutter/material.dart';

Future<void> showCommonDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String primaryButtonText,
  VoidCallback? onPrimaryPressed,
  String? secondaryButtonText,
  VoidCallback? onSecondaryPressed,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (secondaryButtonText != null)
            TextButton(
              onPressed: () {
                if (onSecondaryPressed != null) {
                  onSecondaryPressed();
                }
                Navigator.of(context).pop();
              },
              child: Text(secondaryButtonText),
            ),
          TextButton(
            onPressed: () {
              if (onPrimaryPressed != null) {
                onPrimaryPressed();
              }
              Navigator.of(context).pop();
            },
            child: Text(primaryButtonText),
          ),
        ],
      );
    },
  );
}
