import 'package:hollylist_app/config/constantes.dart';
import 'package:hollylist_app/ui/core/ui/utils/format_date.dart';
import 'package:flutter/material.dart';

/// Champ facultatif de la date de naissance, choisie dans un calendrier et effaçable.
class DateOfBirthField extends StatelessWidget {
  const DateOfBirthField({
    super.key,
    required this.dateOfBirth,
    required this.onChanged,
  });

  final DateTime? dateOfBirth;
  final ValueChanged<DateTime?> onChanged;

  Future<void> _pickDate(BuildContext context) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _initialDate(today),
      firstDate: Constantes.oldestDateOfBirth,
      lastDate: today,
      helpText: 'Date de naissance',
    );
    if (pickedDate == null) return;

    onChanged(pickedDate);
  }

  /// Date ouverte par le calendrier : celle déjà saisie, sinon il y a 30 ans.
  /// Bornée, car le calendrier refuse une date hors de ses limites.
  DateTime _initialDate(DateTime today) {
    final date =
        dateOfBirth ?? DateTime(today.year - 30, today.month, today.day);
    final oldestDate = Constantes.oldestDateOfBirth;
    if (date.isBefore(oldestDate)) return oldestDate;
    if (date.isAfter(today)) return today;

    return date;
  }

  @override
  Widget build(BuildContext context) {
    final birthDate = dateOfBirth;

    return InkWell(
      onTap: () => _pickDate(context),
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Date de naissance (facultatif)',
          prefixIcon: const Icon(Icons.cake_outlined),
          suffixIcon: birthDate == null
              ? const Icon(Icons.calendar_today)
              : IconButton(
                  onPressed: () => onChanged(null),
                  tooltip: 'Effacer la date',
                  icon: const Icon(Icons.clear),
                ),
        ),
        child: Text(formatDate(birthDate) ?? 'Non renseignée'),
      ),
    );
  }
}
