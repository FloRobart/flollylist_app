import 'package:hollylist_app/config/app_config.dart';
import 'package:hollylist_app/config/constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Champ de formulaire pour saisir un prix facultatif : vide, il vaut 0.
class PriceField extends StatelessWidget {
  const PriceField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      inputFormatters: const [PriceInputFormatter()],
      decoration: InputDecoration(
        labelText: 'Prix',
        hintText: 'Ex : 24,99',
        suffixText: AppConfig.currency,
        prefixIcon: const Icon(Icons.sell_outlined),
      ),
      validator: validatePrice,
    );
  }
}

/// Prix facultatif, positif, sous la limite de l'API.
String? validatePrice(String? value) {
  final trimmedValue = value?.trim() ?? '';
  if (trimmedValue.isEmpty) return null;

  final price = parsePrice(trimmedValue);
  if (price == null) return 'Prix invalide';
  if (price > Constantes.maxGiftPrice) return 'Prix trop élevé';

  return null;
}

/// Lit un prix saisi avec une virgule ou un point. Un champ vide vaut 0.
double? parsePrice(String rawPrice) {
  final normalizedPrice = rawPrice.trim().replaceAll(',', '.');
  if (normalizedPrice.isEmpty) return 0;

  return double.tryParse(normalizedPrice);
}

/// Écrit un prix pour le champ de saisie, sans décimales inutiles : 0 donne un champ vide.
String formatPriceForField(double price) {
  if (price == 0) return '';

  final hasCents = price != price.truncateToDouble();
  return hasCents ? price.toStringAsFixed(2) : price.toStringAsFixed(0);
}

/// N'accepte que des chiffres, avec au plus 2 décimales après une virgule ou un point.
class PriceInputFormatter extends TextInputFormatter {
  const PriceInputFormatter();

  static final _validPattern = RegExp(r'^\d*([\.,]\d{0,2})?$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty || _validPattern.hasMatch(newValue.text)) {
      return newValue;
    }

    return oldValue;
  }
}
