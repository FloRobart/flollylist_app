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
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _yearController;
  late TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.people?.name ?? '');
    _descController = TextEditingController(text: widget.people?.description ?? '');
    _yearController = TextEditingController(text: widget.people?.year?.toString() ?? '');
    _linkController = TextEditingController(text: widget.people?.link ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _yearController.dispose();
    _linkController.dispose();
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
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom *'),
                validator: (v) => v == null || v.isEmpty ? 'Requis' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Année (ex: Naissance)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _linkController,
                decoration: const InputDecoration(labelText: 'Lien (Photo, etc.)'),
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
                'name': _nameController.text,
                'description': _descController.text.isEmpty ? null : _descController.text,
                'year': _yearController.text.isEmpty ? null : int.tryParse(_yearController.text),
                'link': _linkController.text.isEmpty ? null : _linkController.text,
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
                'person_id': widget.personId ?? widget.gift?.personId,
              });
            }
          },
          child: const Text('Sauvegarder'),
        ),
      ],
    );
  }
}