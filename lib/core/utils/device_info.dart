import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class DeviceInfoService {
  static Future<Map<String, String>> getInfo() async {
    String network = "Unknown";

    final result = await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.wifi)) {
      network = "WiFi";
    } else if (result.contains(ConnectivityResult.mobile)) {
      network = "Mobile";
    }

    try {
      final response = await http.get(
        Uri.parse("http://ip-api.com/json"),
      );

      final data = jsonDecode(response.body);

      return {
        "ip": data["query"] ?? "",
        "city": data["city"] ?? "",
        "state": data["regionName"] ?? "",
        "network": network,
      };
    } catch (_) {
      return {
        "ip": "",
        "city": "",
        "state": "",
        "network": network,
      };
    }
  }
}