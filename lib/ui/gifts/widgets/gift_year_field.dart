import 'package:flutter/material.dart';

/* Years offered in the list, around the current one */
const int _yearsAfterCurrent = 1;
const int _yearsBeforeCurrent = 20;

/// Liste déroulante de l'année d'un cadeau, avec le choix « Sans année ».
class GiftYearField extends StatelessWidget {
  const GiftYearField({super.key, required this.year, required this.onChanged});

  final int? year;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      initialValue: year,
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Année',
        prefixIcon: Icon(Icons.event_outlined),
      ),
      items: [
        for (final yearOption in giftYearOptions(year, DateTime.now().year))
          DropdownMenuItem<int?>(
            value: yearOption,
            child: Text(yearOption?.toString() ?? 'Sans année'),
          ),
      ],
    );
  }
}

/// Les années proposées, de la plus récente à la plus ancienne, puis « Sans année » (null).
/// L'année déjà choisie y figure toujours, même hors de la plage proposée.
List<int?> giftYearOptions(int? selectedYear, int currentYear) {
  final years = <int>{
    for (
      var year = currentYear + _yearsAfterCurrent;
      year >= currentYear - _yearsBeforeCurrent;
      year--
    )
      year,
    ?selectedYear,
  }.toList()..sort((first, second) => second.compareTo(first));

  return [...years, null];
}
