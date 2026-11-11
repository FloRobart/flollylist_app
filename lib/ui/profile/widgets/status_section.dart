import 'package:flollylist_app/ui/core/themes/theme.dart';
import 'package:flollylist_app/ui/core/ui/utils/format_date.dart';
import 'package:flollylist_app/ui/core/ui/utils/pluralize.dart';
import 'package:flollylist_app/ui/core/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';

class StatusSection extends StatelessWidget {
  const StatusSection({
    super.key,
    required this.isConnected,
    required this.isEmailVerified,
    required this.createdAt,
  });

  final bool isConnected;
  final bool isEmailVerified;
  final DateTime createdAt;

  /// Ancienneté du compte, dans l'unité la plus parlante : « 2 ans », « 3 mois », « 5 jours »...
  String get getDateDiff {
    final difference = DateTime.now().difference(createdAt);
    final days = difference.inDays;
    final hours = difference.inHours;
    final minutes = difference.inMinutes;

    if (days >= 365) return pluralize(days ~/ 365, 'an', 'ans');
    if (days >= 30) return '${days ~/ 30} mois';
    if (days >= 1) return pluralize(days, 'jour', 'jours');
    if (hours >= 1) return pluralize(hours, 'heure', 'heures');
    if (minutes >= 1) return pluralize(minutes, 'minute', 'minutes');

    return 'moins d\'une minute';
  }

  @override
  Widget build(BuildContext context) {
    final creationDate =
        formatDate(createdAt, customFormat: 'EEEE dd MMMM yyyy') ?? 'Inconnu';

    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statut du compte',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 12),

          /// Connection status
          Row(
            children: [
              Icon(
                Icons.link,
                color: isConnected
                    ? AppTheme.successColor
                    : AppTheme.errorColor,
              ),
              const SizedBox(width: 8),
              Flexible(child: Text('${!isConnected ? 'Non ' : ''}Connecté')),
            ],
          ),

          const SizedBox(height: 8),

          /// Email verification status
          Row(
            children: [
              Icon(
                Icons.email,
                color: isEmailVerified
                    ? AppTheme.successColor
                    : AppTheme.warningColor,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text('Email ${!isEmailVerified ? 'non ' : ''}vérifié'),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Account creation date
          Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 8),
              Flexible(
                child: Text('Créé le : $creationDate (Il y a $getDateDiff)'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
