import 'package:hollylist_app/config/constantes.dart';
import 'package:hollylist_app/routing/routes.dart';
import 'package:hollylist_app/ui/auth/code_entry/view_models/code_entry_body_viewmodel.dart';
import 'package:hollylist_app/ui/core/ui/forms/submit_button.dart';
import 'package:hollylist_app/ui/core/ui/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Saisie du code reçu par email, avec l'envoi d'un nouveau code et le changement d'adresse.
class CodeEntryBody extends ConsumerStatefulWidget {
  const CodeEntryBody({super.key});

  @override
  ConsumerState<CodeEntryBody> createState() => _CodeEntryBodyState();
}

class _CodeEntryBodyState extends ConsumerState<CodeEntryBody> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _isSubmitting = false;
  bool _isResending = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  /// Vérifie le code. En cas de succès, le routeur ouvre l'application.
  Future<void> _submitVerification() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) return;

    /* Hidden now: after a right code, this screen is already gone when the verification returns,
       and the message of a previous wrong code would stay over the next screen */
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    setState(() => _isSubmitting = true);
    final viewModel = ref.read(codeEntryBodyViewModelProvider);
    final isCodeValid = await viewModel.verifyCode(_codeController.text);
    if (!mounted) return;

    setState(() => _isSubmitting = false);
    if (isCodeValid) return;

    showMessage(
      context,
      'Code incorrect ou expiré. Vérifiez le dernier email reçu.',
    );
  }

  /// Envoie un nouveau code à la même adresse.
  Future<void> _resendCode() async {
    setState(() => _isResending = true);
    final viewModel = ref.read(codeEntryBodyViewModelProvider);
    final isCodeSent = await viewModel.resendCode();
    if (!mounted) return;

    setState(() => _isResending = false);
    _codeController.clear();
    showMessage(
      context,
      isCodeSent
          ? 'Un nouveau code vous a été envoyé.'
          : 'Impossible d\'envoyer un nouveau code. Réessayez.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final email = ref.watch(codeEntryEmailProvider).value;
    final isBusy = _isSubmitting || _isResending;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Entrez le code de vérification reçu par email${email == null ? '' : ' à :'}',
            textAlign: TextAlign.center,
          ),
          if (email != null)
            Text(
              email,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

          const SizedBox(height: 24),

          /* Code de 6 caractères : des lettres majuscules et des chiffres */
          TextFormField(
            controller: _codeController,
            enabled: !isBusy,
            autofocus: true,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.characters,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.oneTimeCode],
            maxLength: Constantes.loginCodeLength,
            inputFormatters: const [_LoginCodeInputFormatter()],
            onFieldSubmitted: (_) => _submitVerification(),
            style: theme.textTheme.headlineSmall?.copyWith(
              letterSpacing: 8,
              fontWeight: FontWeight.bold,
            ),
            validator: _validateLoginCode,
            decoration: const InputDecoration(
              labelText: 'Code de vérification',
              hintText: 'ABC123',
              counterText: '',
            ),
          ),

          const SizedBox(height: 20),

          SubmitButton(
            onPressed: _submitVerification,
            label: 'Vérifier',
            isLoading: _isSubmitting,
          ),

          const SizedBox(height: 12),

          TextButton.icon(
            onPressed: isBusy ? null : _resendCode,
            icon: const Icon(Icons.refresh),
            label: const Text('Je n\'ai pas reçu le code'),
          ),

          TextButton.icon(
            onPressed: isBusy ? null : () => context.go(AppRoutes.login),
            icon: const Icon(Icons.alternate_email),
            label: const Text('Modifier l\'adresse email'),
          ),
        ],
      ),
    );
  }
}

/// Le code doit avoir exactement la longueur de ceux de Floraccess.
String? _validateLoginCode(String? value) {
  final code = normalizeLoginCode(value ?? '');
  if (code.length != Constantes.loginCodeLength) {
    return 'Le code contient ${Constantes.loginCodeLength} caractères';
  }

  return null;
}

/// Met le code en majuscules et n'accepte que des lettres et des chiffres, comme ceux de l'email.
/// L'ancienne version n'acceptait que des chiffres : les codes avec des lettres ne pouvaient pas être saisis.
class _LoginCodeInputFormatter extends TextInputFormatter {
  const _LoginCodeInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final code = newValue.text.toUpperCase().replaceAll(
      RegExp(r'[^A-Z0-9]'),
      '',
    );

    return TextEditingValue(
      text: code,
      selection: TextSelection.collapsed(offset: code.length),
    );
  }
}
