import 'package:flollylist_app/domain/models/gifts/gift.dart';
import 'package:flollylist_app/domain/models/peoples/people.dart';
import 'package:flollylist_app/ui/core/ui/utils/refresh_peoples_and_gifts.dart';
import 'package:flollylist_app/ui/core/ui/widgets/error_retry_widget.dart';
import 'package:flollylist_app/ui/core/ui/widgets/loading_widget.dart';
import 'package:flollylist_app/ui/gifts/view_models/gift_viewmodel.dart';
import 'package:flollylist_app/ui/peoples/view_models/people_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Attend les proches et les cadeaux, puis construit le contenu avec les deux listes.
/// Affiche un chargement, ou une erreur avec un bouton pour réessayer, tant qu'une liste manque.
class PeoplesAndGiftsBuilder extends ConsumerWidget {
  const PeoplesAndGiftsBuilder({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    List<People> peoples,
    List<Gift> gifts,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final peoplesAsync = ref.watch(peopleViewModelProvider);
    final giftsAsync = ref.watch(giftViewModelProvider);

    final peoples = peoplesAsync.value;
    final gifts = giftsAsync.value;
    if (peoples != null && gifts != null) {
      return builder(context, peoples, gifts);
    }

    final error = peoplesAsync.error ?? giftsAsync.error;
    if (error == null) return const LoadingWidget();

    return ErrorRetryWidget(
      error: error,
      onRetry: () => retryLoadingPeoplesAndGifts(ref),
    );
  }
}
