import 'package:intl/intl.dart';

extension CurrencyHelper on String {
  String get currencyIndian => NumberFormat.currency(
    locale: "en_IN",
    symbol: "₹ ",

    decimalDigits: 2,
  ).format(double.tryParse(this));
}
