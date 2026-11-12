import 'package:hollylist_app/config/assets.dart';
import 'package:flutter/material.dart';

/// Écran affiché le temps de lire la session et le verrouillage dans le stockage local.
/// Il ne montre aucune donnée : l'application peut encore être verrouillée.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.logo192, width: 72, height: 72),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
