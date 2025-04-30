import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceUtils {
  static String formatEuroPrice(BuildContext context, int price) {
    final locale = Localizations.localeOf(context).toString();
    final currencyFormat = NumberFormat.currency(
      locale: locale,
      symbol: '€',
      decimalDigits: 2,
    );

    return currencyFormat.format(price);
  }
}
