import 'package:flutter/material.dart';

/// Affiche un message en bas de l'écran, si le widget est toujours affiché.
void showMessage(
  BuildContext context,
  String message, {
  SnackBarAction? action,
}) {
  if (!context.mounted) return;

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message), action: action));
}
