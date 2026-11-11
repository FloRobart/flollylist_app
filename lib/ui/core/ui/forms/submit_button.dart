import 'package:flutter/material.dart';

/// Bouton de soumission d'un formulaire, désactivé avec un indicateur pendant l'envoi.
class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    this.label = 'Valider',
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            )
          : Text(label),
    );
  }
}
