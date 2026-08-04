import 'package:flutter_test/flutter_test.dart';
import 'package:maxpay/core/constants/extension.dart';

void main() {
  group('formatTransactionDate tests', () {
    test('formats dot-separated with attached PM correctly', () {
      final result = formatTransactionDate("04.08.2026 06:39:52PM");
      expect(result, "04-08-2026, 06:39 PM");
    });

    test('formats dot-separated with attached AM correctly', () {
      final result = formatTransactionDate("04.08.2026 06:40:01AM");
      expect(result, "04-08-2026, 06:40 AM");
    });

    test('formats dash-separated AM/PM correctly', () {
      final result = formatTransactionDate("04-08-2026 09:09 AM");
      expect(result, "04-08-2026, 09:09 AM");
    });

    test('handles empty or dash string safely', () {
      expect(formatTransactionDate(""), "-");
      expect(formatTransactionDate("-"), "-");
      expect(formatTransactionDate("   "), "-");
    });
  });
}
