import 'package:hollylist_app/config/app_config.dart';
import 'package:intl/intl.dart';

/// Formate un prix avec la devise de la configuration, par exemple « 24,99 € ».
String formatPrice(double price) {
  final formatter = NumberFormat.currency(
    locale: AppConfig.localization,
    symbol: AppConfig.currency,
    decimalDigits: 2,
  );

  return formatter.format(price);
}
