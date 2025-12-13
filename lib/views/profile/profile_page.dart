import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pense à ajouter intl dans pubspec.yaml
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/theme_controller.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late VoidCallback _authListener;
  @override
  void initState() {
    super.initState();
    // Charger le profil au démarrage de la page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthController>(context, listen: false).fetchProfile();
    });

    // Écoute les changements d'auth pour rediriger automatiquement si on est déconnecté
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = Provider.of<AuthController>(context, listen: false);
      _authListener = () {
        if (!mounted) return;
        if (!auth.isAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        }
      };
      auth.addListener(_authListener);
    });
  }

  @override
  void dispose() {
    try {
      Provider.of<AuthController>(context, listen: false).removeListener(_authListener);
    } catch (_) {}
    super.dispose();
  }

  void _showEditPseudoDialog(BuildContext context, String currentPseudo) {
    final controller = TextEditingController(text: currentPseudo);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Modifier le pseudo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nouveau pseudo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final success = await Provider.of<AuthController>(context, listen: false)
                  .updateProfile(controller.text);
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success 
                      ? 'Profil mis à jour' 
                      : 'Erreur lors de la mise à jour'
                    ),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    final auth = Provider.of<AuthController>(context, listen: false);
    await auth.logoutServer(); // Appelle l'API logout puis nettoie le local
    
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final themeController = Provider.of<ThemeController>(context);
    final user = auth.userProfile;
    final isLoading = auth.isLoading;

    // Formatage de la date (ex: 12/05/2023)
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? Center(
                  child: ElevatedButton(
                    onPressed: auth.fetchProfile,
                    child: const Text('Recharger le profil'),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Avatar
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          user.pseudo.isNotEmpty ? user.pseudo[0].toUpperCase() : '?',
                          style: const TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      // Carte d'informations
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              // PSEUDO (Modifiable)
                              ListTile(
                                title: const Text('Pseudo'),
                                subtitle: Text(
                                  user.pseudo,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _showEditPseudoDialog(context, user.pseudo),
                                ),
                              ),
                              const Divider(),

                              // EMAIL (Lecture seule)
                              ListTile(
                                title: const Text('Email'),
                                subtitle: Text(user.email),
                                leading: const Icon(Icons.email),
                              ),
                              
                              // EMAIL VERIFIE
                              ListTile(
                                title: const Text('Email vérifié'),
                                trailing: user.isVerifiedEmail
                                    ? const Icon(Icons.check_circle, color: Colors.green)
                                    : const Icon(Icons.error, color: Colors.orange),
                              ),

                              // DATE DE CREATION
                              ListTile(
                                title: const Text('Compte créé le'),
                                subtitle: Text(dateFormat.format(user.createdAt)),
                                leading: const Icon(Icons.calendar_today),
                              ),

                              // STATUT CONNEXION
                              ListTile(
                                title: const Text('Statut'),
                                subtitle: Text(user.isConnected ? 'Connecté' : 'Hors ligne'),
                                leading: const Icon(Icons.wifi),
                                trailing: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: user.isConnected ? Colors.green : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),

                              const Divider(),

                              ListTile(
                                title: const Text('Thème'),
                                subtitle: Text(themeController.currentLabel),
                                leading: const Icon(Icons.brightness_6_outlined),
                                trailing: DropdownButtonHideUnderline(
                                  child: DropdownButton<ThemeMode>(
                                    value: themeController.themeMode,
                                    items: themeController.availableModes
                                        .map(
                                          (mode) => DropdownMenuItem<ThemeMode>(
                                            value: mode,
                                            child: Text(themeController.labelForMode(mode)),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (mode) {
                                      if (mode != null) {
                                        themeController.setThemeMode(mode);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Bouton Déconnexion
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _handleLogout(context),
                          icon: const Icon(Icons.logout),
                          label: const Text('Se déconnecter'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}