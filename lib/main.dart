import 'dart:async';

import 'package:flollylist_app/app.dart';
import 'package:flollylist_app/config/app_config.dart';
import 'package:flollylist_app/data/services/storage/legacy_storage_cleaner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  /// Keep binding initialization and runApp in the same zone.
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// Set system UI mode to manual to control status bar and navigation bar visibility
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
      );

      /// Capture Flutter framework errors
      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        debugPrint('FlutterError caught: ${details.exceptionAsString()}');
        if (details.stack != null) debugPrint(details.stack.toString());
      };

      // Initialize config from runtime + compile-time sources.
      await AppConfig.load();

      // Remove what the former version of the application left in the storage
      await removeLegacyStorage();

      // Initialize intl locale data for formatting dates/numbers (French)
      await initializeDateFormatting(AppConfig.localization);
      Intl.defaultLocale = AppConfig.localization;

      runApp(const ProviderScope(child: App()));
    },
    (error, stack) {
      debugPrint('Uncaught zone error: $error');
      debugPrint(stack.toString());
    },
  );
}
