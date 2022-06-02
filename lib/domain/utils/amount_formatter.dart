import 'package:intl/intl.dart';

String formatNumber(double amount, {String locale = 'en_US', String symbol = r''}) => amount >= 10000
    ? NumberFormat.compactCurrency(
        symbol: symbol,
        locale: locale,
      ).format(amount)
    : NumberFormat.currency(
        locale: locale,
        symbol: symbol,
      ).format(amount);
