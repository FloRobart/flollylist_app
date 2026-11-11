import 'package:flutter/material.dart';

/// Demande confirmation avant une action irréversible. Retourne true si l'utilisateur confirme.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Supprimer',
}) async {
  final bool? isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      final theme = Theme.of(dialogContext);

      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
            ),
            child: Text(confirmLabel),
          ),
        ],
      );
    },
  );

  return isConfirmed ?? false;
}
