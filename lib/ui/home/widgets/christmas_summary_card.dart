import 'package:hollylist_app/ui/core/themes/theme.dart';
import 'package:hollylist_app/ui/core/ui/utils/format_price.dart';
import 'package:hollylist_app/ui/core/ui/utils/pluralize.dart';
import 'package:hollylist_app/ui/core/ui/widgets/card_container.dart';
import 'package:hollylist_app/ui/home/view_models/home_body_viewmodel.dart';
import 'package:flutter/material.dart';

/// Résumé des cadeaux de Noël de l'année : le budget total, et les proches encore sans cadeau.
class ChristmasSummaryCard extends StatelessWidget {
  const ChristmasSummaryCard({super.key, required this.viewModel});

  final HomeBodyViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final giftsCount = pluralize(
      viewModel.giftsCountOfYear,
      'cadeau',
      'cadeaux',
    );
    final peoplesCount = pluralize(
      viewModel.sortedPeoples.length,
      'proche',
      'proches',
    );

    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.redeem, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Noël ${viewModel.year}',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            formatPrice(viewModel.totalOfYearForEveryone),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$giftsCount pour $peoplesCount',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          if (viewModel.peoplesWithoutGiftCount > 0) ...[
            const SizedBox(height: 12),
            _MissingGiftsLine(
              peoplesWithoutGiftCount: viewModel.peoplesWithoutGiftCount,
            ),
          ],
        ],
      ),
    );
  }
}

/// Rappel du nombre de proches qui n'ont pas encore de cadeau cette année.
class _MissingGiftsLine extends StatelessWidget {
  const _MissingGiftsLine({required this.peoplesWithoutGiftCount});

  final int peoplesWithoutGiftCount;

  @override
  Widget build(BuildContext context) {
    final message = peoplesWithoutGiftCount > 1
        ? '$peoplesWithoutGiftCount proches n\'ont pas encore de cadeau'
        : '1 proche n\'a pas encore de cadeau';

    return Row(
      children: [
        const Icon(Icons.info_outline, color: AppTheme.warningColor, size: 20),
        const SizedBox(width: 8),
        Flexible(child: Text(message)),
      ],
    );
  }
}
