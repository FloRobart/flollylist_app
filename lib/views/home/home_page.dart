import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/data_controller.dart';
import '../profile/profile_page.dart';
import 'person_details_page.dart';
import '../widgets/app_dialogs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataController>(context, listen: false).initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    final auth = Provider.of<AuthController>(context);
    final user = auth.userProfile;
    // Make a defensive copy to avoid concurrent mutation issues
    final peoples = List.of(dataController.peoples);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'assets/images/flollylist_icon-144.png',
            width: 36,
            height: 36,
            fit: BoxFit.contain,
          ),
        ),
        title: const Text('FlollyList'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).appBarTheme.foregroundColor
                  ?? Theme.of(context).colorScheme.onPrimary,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    (user != null && user.pseudo.isNotEmpty) ? user.pseudo : 'Profil',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).appBarTheme.foregroundColor
                          ?? Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.person,
                  size: 28,
                  color: Theme.of(context).appBarTheme.foregroundColor
                      ?? Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        final currentYear = DateTime.now().year;
        final giftsBy = dataController.getGiftsByPeopleAndYear();
        final yearKey = currentYear.toString();
        double total = 0.0;
        giftsBy.forEach((_, map) {
          final list = map[yearKey];
          if (list != null) {
            for (var g in list) {
              total += g.price ?? 0.0;
            }
          }
        });
        final totalStr = total.toStringAsFixed(2);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Montant total des cadeaux de Noël de l\'année $currentYear : '),
                      TextSpan(
                        text: '$totalStr €',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Expanded(
              child: peoples.isEmpty
                  ? const Center(child: Text("Aucune personne dans votre liste.\nAjoutez-en une !"))
                  : ListView.builder(
                      itemCount: peoples.length,
                      itemBuilder: (context, index) {
                        final person = peoples[index];
                        final giftsForPerson = giftsBy[person.id]?[yearKey] ?? [];
                        final hasGiftThisYear = giftsForPerson.isNotEmpty;
                        final avatarColor = hasGiftThisYear
                            ? Colors.green
                            : Colors.red.shade700;
                        double personTotal = 0.0;
                        for (var g in giftsForPerson) {
                          personTotal += g.price ?? 0.0;
                        }
                        final personTotalStr = personTotal.toStringAsFixed(2);
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: avatarColor,
                              child: Text(
                                (person.firstName.isNotEmpty ? person.firstName[0] : '?').toUpperCase(),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    person.lastName != null && person.lastName!.isNotEmpty
                                      ? '${person.firstName} ${person.lastName}'
                                      : person.firstName,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '$personTotalStr €',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: person.dateOfBirth != null
                                ? (() {
                                    final parsed = DateTime.tryParse(person.dateOfBirth!);
                                    if (parsed != null) {
                                      return Text('Né(e): ${parsed.day}/${parsed.month}/${parsed.year}');
                                    }
                                    return Text('Date: ${person.dateOfBirth}');
                                  })()
                                : (person.lastName != null && person.lastName!.isNotEmpty
                                    ? Text(person.lastName!)
                                    : const Text("Pas d'informations")),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PersonDetailsPage(person: person),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (_) => const PeopleDialog(),
          );

          if (data != null && context.mounted) {
            await Provider.of<DataController>(context, listen: false).addPeople(data);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}