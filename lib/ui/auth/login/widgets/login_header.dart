import 'package:flollylist_app/config/app_config.dart';
import 'package:flutter/material.dart';

/// Présentation de l'application et réponses aux questions sur la connexion.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appName = AppConfig.appName;

    return Column(
      children: [
        Text(
          'Connectez-vous pour retrouver les cadeaux de vos proches en un coup d’œil. $appName vous permet de noter, pour chacun de vos proches, les cadeaux de chaque année et leur prix.',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        Text(
          '$appName est gratuit, sans publicité, et respecte votre vie privée.',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        _HelpQuestion(
          question: 'Comment créer un compte ?',
          answer: 'Il n\'y a aucune différence pour vous entre la connexion et l\'inscription.\n\nEntrez votre adresse e-mail pour vous connecter ou créer un compte.\n\nSi vous avez déjà un compte avec cette adresse e-mail, vous vous connectez et retrouvez vos données.\nSi vous n’avez pas de compte, un compte vous est créé.',
        ),

        _HelpQuestion(
          question: 'Pourquoi il n\'y a pas de mot de passe ?',
          answer:
              '$appName utilise une méthode d\'authentification sans mot de passe pour simplifier la connexion.\n\nLorsque vous entrez votre adresse e-mail, vous recevez par e-mail un code à usage unique, à saisir pour vérifier votre identité.\n\nCette méthode est plus simple et plus sûre : elle élimine les risques des mots de passe faibles, réutilisés, volés ou oubliés.',
        ),

        _HelpQuestion(
          question: 'Comment sont sécurisées mes données ?',
          answer:
              'Vos proches ne découvrent pas leurs cadeaux : un code, que vous choisissez, verrouille $appName à chaque ouverture.\n\nVos listes ne sont jamais gardées sur l\'appareil : elles restent sur le serveur, accessibles uniquement avec votre compte.\n\nAucune donnée n\'est utilisée à des fins commerciales ou publicitaires, ni partagée avec des tiers. Seul le strict nécessaire est collecté.',
        ),
      ],
    );
  }
}

/// Une question, avec un bouton d'aide qui affiche sa réponse dans une boîte de dialogue.
class _HelpQuestion extends StatelessWidget {
  const _HelpQuestion({required this.question, required this.answer});

  final String question;
  final String answer;

  void _showAnswer(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(question),
        content: Text(answer),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Text(question)),
        IconButton(
          onPressed: () => _showAnswer(context),
          tooltip: 'Afficher la réponse',
          visualDensity: VisualDensity.compact,
          icon: const Icon(Icons.help_outline, size: 20),
        ),
      ],
    );
  }
}
