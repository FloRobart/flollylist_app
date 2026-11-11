import 'package:flollylist_app/ui/auth/code_entry/widgets/code_entry_body.dart';
import 'package:flollylist_app/ui/auth/widgets/auth_base.dart';
import 'package:flutter/material.dart';

/// Écran de validation du code de vérification envoyé à l'utilisateur par email.
class CodeEntryScreen extends StatelessWidget {
  const CodeEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthBase(title: 'Vérifiez votre email', body: CodeEntryBody());
  }
}
