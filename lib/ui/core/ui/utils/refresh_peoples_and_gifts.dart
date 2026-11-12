import 'package:hollylist_app/ui/core/ui/utils/error_message.dart';
import 'package:hollylist_app/ui/core/ui/utils/show_message.dart';
import 'package:hollylist_app/ui/gifts/view_models/gift_viewmodel.dart';
import 'package:hollylist_app/ui/peoples/view_models/people_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Recharge en même temps les proches et les cadeaux depuis l'API (tirer l'écran vers le bas).
/// En cas d'échec, les listes déjà affichées restent à l'écran, avec un message.
Future<void> refreshPeoplesAndGifts(BuildContext context, WidgetRef ref) async {
  try {
    await Future.wait([
      ref.read(peopleViewModelProvider.notifier).refresh(),
      ref.read(giftViewModelProvider.notifier).refresh(),
    ]);
  } catch (error) {
    if (!context.mounted) return;
    showMessage(context, describeError(error));
  }
}

/// Relance le chargement des proches et des cadeaux, après un premier chargement en échec.
void retryLoadingPeoplesAndGifts(WidgetRef ref) {
  ref.invalidate(peopleViewModelProvider);
  ref.invalidate(giftViewModelProvider);
}
