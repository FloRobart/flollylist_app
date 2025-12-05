import 'package:flutter/material.dart';
import '../../models/people_model.dart';
import '../../models/gift_model.dart';

class PeopleDialog extends StatefulWidget {
  final People? people; // Null = Création, Objet = Modification

  const PeopleDialog({super.key, this.people});

  @override
  State<PeopleDialog> createState() => _PeopleDialogState();
}

class _PeopleDialogState extends State<PeopleDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _dobController;
  String? _dobValue; // stocke la date complète en ISO (pour l'envoi)

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.people?.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.people?.lastName ?? '');
    // Préparer l'affichage et la valeur ISO si disponible
    if (widget.people?.dateOfBirth != null) {
      _dobValue = widget.people!.dateOfBirth;
      final parsed = DateTime.tryParse(widget.people!.dateOfBirth!);
      if (parsed != null) {
        _dobController = TextEditingController(text: '${parsed.day}/${parsed.month}/${parsed.year}');
      } else {
        _dobController = TextEditingController(text: widget.people!.dateOfBirth!);
      }
    } else {
      _dobController = TextEditingController(text: '');
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.people == null ? 'Ajouter une personne' : 'Modifier'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'Prénom *'),
                validator: (v) => v == null || v.isEmpty ? 'Requis' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Nom (facultatif)'),
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Année de naissance (sélectionnez)'),
                readOnly: true,
                onTap: () async {
                  DateTime initial = DateTime.now();
                  if (widget.people?.dateOfBirth != null) {
                    final parsed = DateTime.tryParse(widget.people!.dateOfBirth!);
                    if (parsed != null) initial = parsed;
                  }
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: initial,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _dobValue = picked.toIso8601String();
                      _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // On retourne une Map avec les données
              Navigator.pop(context, {
                'first_name': _firstNameController.text,
                'last_name': _lastNameController.text.isEmpty ? null : _lastNameController.text,
                'date_of_birth': _dobValue,
              });
            }
          },
          child: const Text('Sauvegarder'),
        ),
      ],
    );
  }
}

class GiftDialog extends StatefulWidget {
  final Gift? gift;
  // On a besoin de l'ID de la personne à qui on offre le cadeau (pour la création)
  final int? personId; 

  const GiftDialog({super.key, this.gift, this.personId});

  @override
  State<GiftDialog> createState() => _GiftDialogState();
}

class _GiftDialogState extends State<GiftDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _yearController;
  late TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.gift?.name ?? '');
    _descController = TextEditingController(text: widget.gift?.description ?? '');
    // Par défaut, si création, on peut mettre l'année en cours
    _yearController = TextEditingController(text: widget.gift?.year?.toString() ?? DateTime.now().year.toString());
    _linkController = TextEditingController(text: widget.gift?.link ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.gift == null ? 'Ajouter un cadeau' : 'Modifier le cadeau'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom du cadeau *'),
                validator: (v) => v == null || v.isEmpty ? 'Requis' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description / Idées'),
                maxLines: 2,
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Année du Noël/Événement'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _linkController,
                decoration: const InputDecoration(labelText: 'Lien (Boutique, etc.)'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, {
                'name': _nameController.text,
                'description': _descController.text.isEmpty ? null : _descController.text,
                'year': _yearController.text.isEmpty ? null : int.tryParse(_yearController.text),
                'link': _linkController.text.isEmpty ? null : _linkController.text,
                'people_id': widget.personId ?? widget.gift?.personId,
              });
            }
          },
          child: const Text('Sauvegarder'),
        ),
      ],
    );
  }
}