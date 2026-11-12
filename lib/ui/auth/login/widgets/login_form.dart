import 'package:hollylist_app/routing/routes.dart';
import 'package:hollylist_app/ui/auth/login/view_models/login_body_viewmodel.dart';
import 'package:hollylist_app/ui/core/ui/forms/form_validators.dart';
import 'package:hollylist_app/ui/core/ui/forms/submit_button.dart';
import 'package:hollylist_app/ui/core/ui/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Formulaire de connexion et d'inscription : une adresse email suffit.
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key, required this.initialEmail, this.errorMessage});

  final String? initialEmail;
  final String? errorMessage;

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail ?? '');

    final errorMessage = widget.errorMessage;
    if (errorMessage == null || errorMessage.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showMessage(context, errorMessage);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// Envoie la demande de code de connexion, puis passe à la saisie du code.
  Future<void> _submitLoginRequest() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final viewModel = ref.read(loginBodyViewModelProvider);
    final isCodeSent = await viewModel.loginRequest(_emailController.text);
    if (!mounted) return;

    setState(() => _isSubmitting = false);
    if (!isCodeSent) {
      showMessage(
        context,
        'Échec de la connexion. Vérifiez l\'adresse email et réessayez.',
      );
      return;
    }

    context.go(AppRoutes.codeEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /* Champ de saisie de l'email */
            TextFormField(
              controller: _emailController,
              enabled: !_isSubmitting,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submitLoginRequest(),
              autofillHints: const [AutofillHints.email],
              validator: validateEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Entrez votre adresse email',
                prefixIcon: Icon(Icons.mail),
              ),
            ),

            const SizedBox(height: 16),

            /* Bouton de connexion */
            SubmitButton(
              onPressed: _submitLoginRequest,
              label: 'Se connecter / S\'inscrire',
              isLoading: _isSubmitting,
            ),
          ],
        ),
      ),
    );
  }
}
