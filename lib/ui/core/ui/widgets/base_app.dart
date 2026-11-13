import 'package:hollylist_app/ui/core/ui/widgets/header.dart';
import 'package:flutter/material.dart';

/// Squelette commun des écrans de l'application : en-tête, contenu rafraîchissable et bouton d'ajout.
class BaseApp extends StatelessWidget {
  const BaseApp({
    super.key,
    required this.body,
    required this.onRefresh,
    this.floatingActionButton,
  });

  /* On a large screen, the lines would be too long to read */
  static const double _maxContentWidth = 900;

  final Widget body;
  final Future<void> Function() onRefresh;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* En-tête */
      appBar: const Header(),

      /* Contenu principal */
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: _maxContentWidth,
                    ),
                    child: body,
                  ),
                ),
              ),
            );
          },
        ),
      ),

      floatingActionButton: floatingActionButton,
    );
  }
}
