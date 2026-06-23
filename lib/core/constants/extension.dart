import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/api_routes.dart';

String formatTransactionDate(String isoDateString) {
  try {
    DateTime dateTime = DateTime.parse(isoDateString).toLocal();
    final DateFormat formatter = DateFormat('dd-MM-yyyy, hh:mm a');
    return formatter.format(dateTime);
  } catch (e) {
    print('Error formatting date: $e');
    return isoDateString;
  }
}

extension UrlHelper on String {
  String addToBase() {
    try {
      if (startsWith('http://') || startsWith('https://')) {
        return this;
      }

      final baseUrl = ApiRoutes.baseURL.split('/api').first;

      final formattedBase =
          baseUrl.endsWith('/')
              ? baseUrl.substring(0, baseUrl.length - 1)
              : baseUrl;

      final formattedPath =
          startsWith('/') ? substring(1) : this;

      return '$formattedBase/$formattedPath';
    } catch (e) {
      print('Error in addToBase: $e');
      return this;
    }
  }
}