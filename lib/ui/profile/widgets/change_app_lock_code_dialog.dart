import 'package:flollylist_app/ui/app_lock/view_models/app_lock_viewmodel.dart';
import 'package:flollylist_app/ui/app_lock/widgets/app_lock_code_field.dart';
import 'package:flutter/material.dart';

/// Demande un nouveau code de verrouillage, saisi deux fois.
/// Retourne le nouveau code, ou null si l'utilisateur annule.
Future<String?> showChangeAppLockCodeDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (_) => const _ChangeAppLockCodeDialog(),
  );
}

class _ChangeAppLockCodeDialog extends StatefulWidget {
  const _ChangeAppLockCodeDialog();

  @override
  State<_ChangeAppLockCodeDialog> createState() =>
      _ChangeAppLockCodeDialogState();
}

class _ChangeAppLockCodeDialogState extends State<_ChangeAppLockCodeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _confirmationController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(_codeController.text);
  }

  String? _validateConfirmation(String? value) {
    if (value != _codeController.text) return 'Les deux codes sont différents';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Changer le code'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLockCodeField(
              controller: _codeController,
              labelText: 'Nouveau code',
              validator: validateAppLockCode,
              autofocus: true,
            ),
            const SizedBox(height: 16),
            AppLockCodeField(
              controller: _confirmationController,
              labelText: 'Confirmez le code',
              validator: _validateConfirmation,
              onFieldSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Enregistrer')),
      ],
    );
  }
}
