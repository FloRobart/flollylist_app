import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home_page.dart';
import '../../controllers/auth_controller.dart';
import 'code_verification_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _pseudoController = TextEditingController();
  bool _isRegistering = false;

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  void _loadSavedEmail() async {
    final email = Provider.of<AuthController>(context, listen: false).currentEmail;
    if (email != null) _emailController.text = email;
  }

  void _submit() async {
    final auth = Provider.of<AuthController>(context, listen: false);
    
    // On garde en mémoire si c'était une inscription avant l'appel
    final wasRegistering = _isRegistering;

    final success = await auth.requestLogin(
      _emailController.text,
      pseudo: _isRegistering ? _pseudoController.text : null,
    );

    if (success && mounted) {
      if (wasRegistering) {
        // Si c'est une inscription, on est déjà connecté (JWT reçu direct)
        // -> Direction la page d'accueil
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
      } else {
        // Si c'est une connexion, il faut vérifier le code
        // -> Direction la page de code
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CodeVerificationPage()),
        );
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la requête')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/flollylist_icon-192.png', height: 100),
              const SizedBox(height: 32),
              Text(
                _isRegistering ? 'Inscription' : 'Connexion',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              if (_isRegistering) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _pseudoController,
                  decoration: const InputDecoration(
                    labelText: 'Pseudo',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isRegistering ? "S'inscrire" : "Se connecter"),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isRegistering = !_isRegistering;
                  });
                },
                child: Text(_isRegistering
                    ? "J'ai déjà un compte"
                    : "Créer un compte"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}