import 'package:flollylist_app/ui/app_lock/view_models/app_lock_viewmodel.dart';
import 'package:flollylist_app/ui/app_lock/widgets/app_lock_code_field.dart';
import 'package:flollylist_app/ui/core/ui/forms/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Choix du code de verrouillage, saisi deux fois pour éviter une faute de frappe.
class AppLockSetupForm extends ConsumerStatefulWidget {
  const AppLockSetupForm({super.key});

  @override
  ConsumerState<AppLockSetupForm> createState() => _AppLockSetupFormState();
}

class _AppLockSetupFormState extends ConsumerState<AppLockSetupForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _confirmationController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _codeController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  Future<void> _submitCode() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    await ref.read(appLockViewModelProvider).setCode(_codeController.text);
    if (mounted) setState(() => _isSubmitting = false);
  }

  String? _validateConfirmation(String? value) {
    if (value != _codeController.text) return 'Les deux codes sont différents';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Ce code vous sera demandé à chaque ouverture de FlollyList, pour que vos proches ne découvrent pas leurs cadeaux sur votre appareil.',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          AppLockCodeField(
            controller: _codeController,
            labelText: 'Nouveau code',
            validator: validateAppLockCode,
            enabled: !_isSubmitting,
            autofocus: true,
          ),

          const SizedBox(height: 16),

          AppLockCodeField(
            controller: _confirmationController,
            labelText: 'Confirmez le code',
            validator: _validateConfirmation,
            enabled: !_isSubmitting,
            onFieldSubmitted: (_) => _submitCode(),
          ),

          const SizedBox(height: 20),

          SubmitButton(
            onPressed: _submitCode,
            label: 'Enregistrer',
            isLoading: _isSubmitting,
          ),
        ],
      ),
    );
  }
}
