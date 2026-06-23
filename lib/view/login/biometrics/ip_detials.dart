import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getIpDetails() async {
  final response = await http.get(
    Uri.parse("http://ip-api.com/json"),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  throw Exception("Unable to fetch IP");
}