import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../controllers/app_lock_controller.dart';

class AppLockPage extends StatefulWidget {
  const AppLockPage({super.key});

  @override
  State<AppLockPage> createState() => _AppLockPageState();
}

class _AppLockPageState extends State<AppLockPage> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lockController = context.watch<AppLockController>();
    final isSetup = lockController.needsSetup;
    final error = lockController.errorMessage;

    Future<void> handleSubmit() async {
      await lockController.submitPassword(_passwordController.text);
      if (lockController.errorMessage == null && lockController.isUnlocked) {
        FocusScope.of(context).unfocus();
        _passwordController.clear();
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isSetup
                        ? 'Definis un mot de passe pour l\'application'
                        : 'Entrez le mot de passe de l\'application',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isSetup
                        ? 'Ce mot de passe sera demande a chaque ouverture. Utilise uniquement des chiffres.'
                        : 'Pour continuer, saisis ton mot de passe numerique.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(255),
                    ],
                    onChanged: (_) => lockController.clearError(),
                    onSubmitted: (_) => handleSubmit(),
                    decoration: InputDecoration(
                      labelText: isSetup ? 'Nouveau mot de passe' : 'Mot de passe',
                      errorText: error,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: handleSubmit,
                      child: Text(isSetup ? 'Enregistrer' : 'Déverrouiller'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
