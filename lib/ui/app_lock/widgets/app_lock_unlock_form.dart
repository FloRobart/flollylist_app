import 'package:hollylist_app/ui/app_lock/view_models/app_lock_viewmodel.dart';
import 'package:hollylist_app/ui/app_lock/widgets/app_lock_code_field.dart';
import 'package:hollylist_app/ui/core/ui/forms/submit_button.dart';
import 'package:hollylist_app/ui/core/ui/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Saisie du code pour déverrouiller l'application.
class AppLockUnlockForm extends ConsumerStatefulWidget {
  const AppLockUnlockForm({super.key});

  @override
  ConsumerState<AppLockUnlockForm> createState() => _AppLockUnlockFormState();
}

class _AppLockUnlockFormState extends ConsumerState<AppLockUnlockForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _isSubmitting = false;
  bool _isCodeWrong = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submitCode() async {
    setState(() => _isCodeWrong = false);
    if (_isSubmitting || !_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final isUnlocked = await ref
        .read(appLockViewModelProvider)
        .unlock(_codeController.text);
    if (!mounted || isUnlocked) return;

    setState(() {
      _isSubmitting = false;
      _isCodeWrong = true;
    });
    _codeController.clear();
  }

  /// Code oublié : après confirmation, déconnecte l'utilisateur.
  Future<void> _forgetCode() async {
    final isConfirmed = await showConfirmDialog(
      context,
      title: 'Code oublié ?',
      message: 'Vous allez être déconnecté. Reconnectez-vous avec votre adresse email pour choisir un nouveau code.',
      confirmLabel: 'Me déconnecter',
    );
    if (!isConfirmed) return;

    await ref.read(appLockViewModelProvider).forgetCode();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Entrez votre code pour accéder à vos listes de cadeaux.',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          AppLockCodeField(
            controller: _codeController,
            labelText: 'Code',
            validator: validateAppLockCode,
            enabled: !_isSubmitting,
            autofocus: true,
            onFieldSubmitted: (_) => _submitCode(),
          ),

          if (_isCodeWrong)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Code incorrect.',
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),

          const SizedBox(height: 20),

          SubmitButton(
            onPressed: _submitCode,
            label: 'Déverrouiller',
            isLoading: _isSubmitting,
          ),

          const SizedBox(height: 12),

          TextButton(
            onPressed: _isSubmitting ? null : _forgetCode,
            child: const Text('Code oublié ?'),
          ),
        ],
      ),
    );
  }
}
