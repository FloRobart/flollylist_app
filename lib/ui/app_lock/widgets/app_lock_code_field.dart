import 'package:flollylist_app/config/constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Champ de saisie d'un code de verrouillage : des chiffres, masqués.
class AppLockCodeField extends StatelessWidget {
  const AppLockCodeField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.enabled = true,
    this.autofocus = false,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String> validator;
  final bool enabled;
  final bool autofocus;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      maxLength: Constantes.maxAppLockCodeLength,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(Icons.pin_outlined),
        counterText: '',
      ),
    );
  }
}
