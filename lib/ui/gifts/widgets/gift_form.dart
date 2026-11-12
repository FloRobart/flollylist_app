import 'package:hollylist_app/config/constantes.dart';
import 'package:hollylist_app/domain/models/gifts/gift.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert.dart';
import 'package:hollylist_app/domain/models/peoples/people.dart';
import 'package:hollylist_app/ui/core/ui/forms/form_validators.dart';
import 'package:hollylist_app/ui/core/ui/forms/price_field.dart';
import 'package:hollylist_app/ui/core/ui/forms/submit_button.dart';
import 'package:hollylist_app/ui/core/ui/widgets/form_sheet.dart';
import 'package:hollylist_app/ui/gifts/widgets/gift_year_field.dart';
import 'package:flutter/material.dart';

/// Formulaire d'ajout ou de modification d'un cadeau. Renvoie un [GiftUpsert] à sa validation.
class GiftForm extends StatefulWidget {
  const GiftForm({
    super.key,
    required this.peoples,
    required this.peopleId,
    this.initialGift,
  });

  /// Les proches à qui le cadeau peut être offert.
  final List<People> peoples;

  /// Le proche choisi au départ.
  final int peopleId;

  /// Le cadeau à modifier, ou null pour en ajouter un.
  final Gift? initialGift;

  @override
  State<GiftForm> createState() => _GiftFormState();
}

class _GiftFormState extends State<GiftForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _linkController;
  late int _peopleId;
  int? _year;

  bool get _isCreation => widget.initialGift == null;

  @override
  void initState() {
    super.initState();
    final gift = widget.initialGift;

    _nameController = TextEditingController(text: gift?.name ?? '');
    _priceController = TextEditingController(
      text: formatPriceForField(gift?.price ?? 0),
    );
    _descriptionController = TextEditingController(
      text: gift?.description ?? '',
    );
    _linkController = TextEditingController(text: gift?.link ?? '');
    _peopleId = widget.peopleId;

    /* A new gift is for this year's Christmas, unless the user chooses another year */
    _year = _isCreation ? DateTime.now().year : gift?.year;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(
      GiftUpsert(
        name: _nameController.text.trim(),
        description: emptyToNull(_descriptionController.text),
        year: _year,
        price: parsePrice(_priceController.text) ?? 0,
        link: emptyToNull(_linkController.text),
        peopleId: _peopleId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: FormSheetBody(
        title: _isCreation ? 'Ajouter un cadeau' : 'Modifier le cadeau',
        children: [
          TextFormField(
            controller: _nameController,
            autofocus: _isCreation,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            maxLength: Constantes.maxGiftNameLength,
            validator: (value) => validateRequiredText(
              value,
              maxLength: Constantes.maxGiftNameLength,
            ),
            decoration: const InputDecoration(
              labelText: 'Cadeau',
              hintText: 'Ex : un puzzle de 1000 pièces',
              prefixIcon: Icon(Icons.card_giftcard),
              counterText: '',
            ),
          ),

          const SizedBox(height: 16),

          _GiftPeopleField(
            peoples: widget.peoples,
            peopleId: _peopleId,
            onChanged: (peopleId) => setState(() => _peopleId = peopleId),
          ),

          const SizedBox(height: 16),

          GiftYearField(
            year: _year,
            onChanged: (year) => setState(() => _year = year),
          ),

          const SizedBox(height: 16),

          PriceField(controller: _priceController),

          const SizedBox(height: 16),

          TextFormField(
            controller: _descriptionController,
            textCapitalization: TextCapitalization.sentences,
            minLines: 2,
            maxLines: 5,
            maxLength: Constantes.maxGiftDescriptionLength,
            validator: (value) => validateOptionalText(
              value,
              maxLength: Constantes.maxGiftDescriptionLength,
            ),
            decoration: const InputDecoration(
              labelText: 'Description, idées (facultatif)',
              prefixIcon: Icon(Icons.notes),
              alignLabelWithHint: true,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: _linkController,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            maxLength: Constantes.maxGiftLinkLength,
            validator: (value) => validateOptionalText(
              value,
              maxLength: Constantes.maxGiftLinkLength,
            ),
            decoration: const InputDecoration(
              labelText: 'Lien (boutique...), facultatif',
              prefixIcon: Icon(Icons.link),
              counterText: '',
            ),
          ),

          const SizedBox(height: 24),

          SubmitButton(onPressed: _submit, label: 'Enregistrer'),
        ],
      ),
    );
  }
}

/// Liste déroulante du proche à qui le cadeau est offert : un cadeau peut changer de proche.
class _GiftPeopleField extends StatelessWidget {
  const _GiftPeopleField({
    required this.peoples,
    required this.peopleId,
    required this.onChanged,
  });

  final List<People> peoples;
  final int peopleId;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      initialValue: peopleId,
      isExpanded: true,
      onChanged: (selectedPeopleId) {
        if (selectedPeopleId == null) return;
        onChanged(selectedPeopleId);
      },
      decoration: const InputDecoration(
        labelText: 'Pour',
        prefixIcon: Icon(Icons.person_outline),
      ),
      items: [
        for (final people in peoples)
          DropdownMenuItem<int>(
            value: people.id,
            child: Text(people.fullName, overflow: TextOverflow.ellipsis),
          ),
      ],
    );
  }
}
