import 'package:flutter/material.dart';

/// Ouvre un formulaire dans une feuille en bas de l'écran. Retourne ce que le formulaire renvoie
/// à sa validation, ou null si l'utilisateur le ferme.
Future<T?> showFormSheet<T>(BuildContext context, Widget form) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => form,
  );
}

/// Contenu défilant d'une feuille de formulaire, qui remonte au-dessus du clavier.
class FormSheetBody extends StatelessWidget {
  const FormSheetBody({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, keyboardHeight + 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
