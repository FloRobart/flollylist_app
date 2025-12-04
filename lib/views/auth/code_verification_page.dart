import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../home/home_page.dart';

class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({super.key});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verifyCode() async {
    if (_formKey.currentState!.validate()) {
      final auth = Provider.of<AuthController>(context, listen: false);
      
      // Appel de la méthode confirmLogin du contrôleur
      // Elle utilise l'email et le _tempToken stockés dans le contrôleur lors de l'étape précédente
      final success = await auth.confirmLogin(_codeController.text);

      if (success && mounted) {
        // Redirection vers la page d'accueil en supprimant l'historique de navigation
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code invalide ou expiré'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // On écoute le contrôleur pour afficher l'état de chargement
    final isLoading = context.select<AuthController, bool>((c) => c.isLoading);
    final email = context.select<AuthController, String?>((c) => c.currentEmail);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vérification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mark_email_unread, size: 64, color: Colors.grey),
                  const SizedBox(height: 24),
                  Text(
                    'Code envoyé !',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Veuillez entrer le code à 6 chiffres envoyé à :',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    email ?? 'votre adresse email',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Champ de saisie du code
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24, 
                      letterSpacing: 8, 
                      fontWeight: FontWeight.bold
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      hintText: '000000',
                      counterText: "", // Cache le compteur "0/6"
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.length != 6) {
                        return 'Le code doit contenir 6 chiffres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Bouton de validation
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _verifyCode,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Valider'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Option pour renvoyer le code (UX)
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            // On réutilise la méthode requestLogin pour renvoyer un code
                            final auth = Provider.of<AuthController>(context, listen: false);
                            if (email != null) {
                              await auth.requestLogin(email);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Nouveau code envoyé')),
                                );
                              }
                            }
                          },
                    child: const Text("Je n'ai pas reçu le code"),
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