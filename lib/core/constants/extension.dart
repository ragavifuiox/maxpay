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
  String addToBase(String path) {
    try {
 
      if (path.startsWith('http://') || path.startsWith('https://')) {
        return path;
      }

      final baseUrl = ApiRoutes.baseURL.split('/api').first;
      final formattedBase =
          baseUrl.endsWith('/')
              ? baseUrl.substring(0, baseUrl.length - 1)
              : baseUrl;

      final formattedPath =
          path.startsWith('/') ? path.substring(1) : path;

      return '$formattedBase/$formattedPath';
    } catch (e) {
      print('Error in addToBase: $e');
      return path;
    }
  }
}
