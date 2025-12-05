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
    // Make a defensive copy to avoid concurrent mutation issues
    final peoples = List.of(dataController.peoples);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlollyList'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          )
        ],
      ),
      body: peoples.isEmpty
          ? const Center(child: Text("Aucune personne dans votre liste.\nAjoutez-en une !"))
          : ListView.builder(
              itemCount: peoples.length,
              itemBuilder: (context, index) {
                final person = peoples[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(child: Text((person.firstName.isNotEmpty ? person.firstName[0] : '?').toUpperCase())),
                    title: Text(
                      person.lastName != null && person.lastName!.isNotEmpty
                        ? '${person.firstName} ${person.lastName}'
                        : person.firstName,
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