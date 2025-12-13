import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/people_model.dart';
import '../../controllers/data_controller.dart';
import '../widgets/app_dialogs.dart';

class PersonDetailsPage extends StatelessWidget {
  final People person;

  const PersonDetailsPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    final allGifts = dataController.getGiftsByPeopleAndYear();
    final giftsByYear = allGifts[person.id] ?? {};
    
    // Trier les années (descendant)
    final sortedYears = giftsByYear.keys.toList()
      ..sort((a, b) {
        if (a == 'Autre') return 1;
        if (b == 'Autre') return -1;
        return b.compareTo(a);
      });

    return Scaffold(
      appBar: AppBar(
        title: Text(person.firstName + (person.lastName != null ? ' ${person.lastName}' : '')),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final data = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (_) => PeopleDialog(people: person), // Mode Edit
              );
              if (data != null && context.mounted) {
                await Provider.of<DataController>(context, listen: false).updatePeople(person.id, data);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Confirmer'),
                  content: const Text('Supprimer cette personne et tous ses cadeaux ?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Non')),
                    TextButton(
                      onPressed: () {
                        Provider.of<DataController>(context, listen: false).deletePeople(person.id);
                        Navigator.pop(ctx); // Close dialog
                        Navigator.pop(context); // Back to Home
                      },
                      child: const Text('Oui'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: sortedYears.length,
        itemBuilder: (context, index) {
          final year = sortedYears[index];
          final gifts = giftsByYear[year]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  year,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ...gifts.map((gift) => ListTile(
                title: Text(gift.name),
                subtitle: (gift.link != null && gift.link!.isNotEmpty) || gift.price != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (gift.link != null && gift.link!.isNotEmpty) Text(gift.link!),
                          if (gift.price != null)
                            Text('Prix: ${gift.price!.toStringAsFixed(2)} €'),
                        ],
                      )
                    : null,
                leading: const Icon(Icons.card_giftcard),
                
                // 1. AJOUT DU onLongPress ICI
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Supprimer ce cadeau ?'),
                      content: Text('Voulez-vous vraiment supprimer "${gift.name}" ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Non'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // 1. Fermer la fenêtre de dialogue
                            Navigator.pop(ctx);
                            
                            // 2. Appeler la suppression dans le contrôleur
                            await Provider.of<DataController>(context, listen: false)
                                .deleteGift(gift.id);
                                
                            // 3. (Optionnel) Petit message de confirmation
                            if (context.mounted) {
                              final theme = Theme.of(context);
                              final snackTheme = theme.snackBarTheme;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: snackTheme.backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
                                  content: Text(
                                    '${gift.name} a été supprimé',
                                    style: snackTheme.contentTextStyle ??
                                        TextStyle(color: theme.colorScheme.onSurfaceVariant),
                                  ),
                                  duration: const Duration(seconds: 6),
                                  action: SnackBarAction(
                                    label: 'Annuler',
                                    textColor: snackTheme.actionTextColor ?? theme.colorScheme.secondary,
                                    onPressed: () async {
                                      // LOGIQUE D'ANNULATION : On recrée le cadeau à l'identique
                                      
                                      // 1. On prépare les données récupérées de l'objet 'gift' supprimé
                                      final dataToRestore = {
                                        'name': gift.name,
                                        'description': gift.description,
                                        'year': gift.year,
                                        'link': gift.link,
                                        'price': gift.price,
                                        'people_id': gift.personId,
                                      };

                                      // 2. On utilise la méthode d'ajout existante
                                      await Provider.of<DataController>(context, listen: false)
                                          .addGift(dataToRestore);
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Oui', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final data = await showDialog<Map<String, dynamic>>(
                          context: context,
                          builder: (_) => GiftDialog(gift: gift),
                        );
                        if (data != null && context.mounted) {
                          await Provider.of<DataController>(context, listen: false).updateGift(gift.id, data);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Supprimer ce cadeau ?'),
                            content: Text('Voulez-vous vraiment supprimer "${gift.name}" ?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Non'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(ctx);

                                  await Provider.of<DataController>(context, listen: false)
                                      .deleteGift(gift.id);

                                  if (context.mounted) {
                                          final theme = Theme.of(context);
                                          final snackTheme = theme.snackBarTheme;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: snackTheme.backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
                                              content: Text(
                                                '${gift.name} a été supprimé',
                                                style: snackTheme.contentTextStyle ??
                                                    TextStyle(color: theme.colorScheme.onSurfaceVariant),
                                              ),
                                              duration: const Duration(seconds: 4),
                                              action: SnackBarAction(
                                                label: 'Annuler',
                                                textColor: snackTheme.actionTextColor ?? theme.colorScheme.secondary,
                                                onPressed: () async {
                                                  final dataToRestore = {
                                                    'name': gift.name,
                                                    'description': gift.description,
                                                    'year': gift.year,
                                                    'link': gift.link,
                                                    'price': gift.price,
                                                    'people_id': gift.personId,
                                                  };

                                                  await Provider.of<DataController>(context, listen: false)
                                                      .addGift(dataToRestore);
                                                },
                                              ),
                                            ),
                                          );
                                  }
                                },
                                child: const Text('Oui', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
              const Divider(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (_) => GiftDialog(personId: person.id), // On passe l'ID de la personne
          );
          if (data != null && context.mounted) {
            await Provider.of<DataController>(context, listen: false).addGift(data);
          }
        },
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}