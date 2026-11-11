import 'package:flollylist_app/domain/models/peoples/people.dart';
import 'package:flollylist_app/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';

/// Avatar d'un proche, avec l'initiale de son prénom : vert s'il a déjà un cadeau cette année,
/// rouge s'il n'en a pas encore, pour voir d'un coup d'œil à qui il en manque un.
class PeopleAvatar extends StatelessWidget {
  const PeopleAvatar({
    super.key,
    required this.people,
    required this.hasGiftThisYear,
    this.radius = 22,
  });

  final People people;
  final bool hasGiftThisYear;
  final double radius;

  String get _initial {
    final firstName = people.firstName.trim();
    if (firstName.isEmpty) return '?';

    return firstName.characters.first.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: hasGiftThisYear
          ? 'A déjà un cadeau cette année'
          : 'Pas encore de cadeau cette année',
      child: CircleAvatar(
        radius: radius,
        backgroundColor: hasGiftThisYear
            ? AppTheme.successColor
            : AppTheme.errorColor,
        foregroundColor: Colors.white,
        child: Text(
          _initial,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: radius * 0.8),
        ),
      ),
    );
  }
}
