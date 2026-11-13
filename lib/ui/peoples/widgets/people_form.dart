import 'package:hollylist_app/config/constantes.dart';
import 'package:hollylist_app/domain/models/peoples/people.dart';
import 'package:hollylist_app/domain/models/peoples/upsert/people_upsert.dart';
import 'package:hollylist_app/ui/core/ui/forms/form_validators.dart';
import 'package:hollylist_app/ui/core/ui/forms/submit_button.dart';
import 'package:hollylist_app/ui/core/ui/widgets/form_sheet.dart';
import 'package:hollylist_app/ui/peoples/widgets/date_of_birth_field.dart';
import 'package:flutter/material.dart';

/// Formulaire d'ajout ou de modification d'un proche. Renvoie un [PeopleUpsert] à sa validation.
class PeopleForm extends StatefulWidget {
  const PeopleForm({super.key, this.initialPeople});

  /// Le proche à modifier, ou null pour en ajouter un.
  final People? initialPeople;

  @override
  State<PeopleForm> createState() => _PeopleFormState();
}

class _PeopleFormState extends State<PeopleForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  DateTime? _dateOfBirth;

  bool get _isCreation => widget.initialPeople == null;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.initialPeople?.firstName ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.initialPeople?.lastName ?? '',
    );
    _dateOfBirth = widget.initialPeople?.dateOfBirth;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(
      PeopleUpsert(
        firstName: _firstNameController.text.trim(),
        lastName: emptyToNull(_lastNameController.text),
        dateOfBirth: _dateOfBirth,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: FormSheetBody(
        title: _isCreation ? 'Ajouter un proche' : 'Modifier le proche',
        children: [
          TextFormField(
            controller: _firstNameController,
            autofocus: _isCreation,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            maxLength: Constantes.maxNameLength,
            validator: (value) => validateRequiredText(
              value,
              maxLength: Constantes.maxNameLength,
            ),
            decoration: const InputDecoration(
              labelText: 'Prénom',
              prefixIcon: Icon(Icons.person_outline),
              counterText: '',
            ),
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: _lastNameController,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            maxLength: Constantes.maxNameLength,
            validator: (value) => validateOptionalText(
              value,
              maxLength: Constantes.maxNameLength,
            ),
            decoration: const InputDecoration(
              labelText: 'Nom (facultatif)',
              prefixIcon: Icon(Icons.badge_outlined),
              counterText: '',
            ),
          ),

          const SizedBox(height: 16),

          DateOfBirthField(
            dateOfBirth: _dateOfBirth,
            onChanged: (dateOfBirth) =>
                setState(() => _dateOfBirth = dateOfBirth),
          ),

          const SizedBox(height: 24),

          SubmitButton(onPressed: _submit, label: 'Enregistrer'),
        ],
      ),
    );
  }
}
