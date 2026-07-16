import 'package:flutter/services.dart';

class UpiChannel {
  static const MethodChannel _channel =
      MethodChannel("com.paylink.retailor/upi_chooser");

  static Future<List<dynamic>> getInstalledApps() async {
    return await _channel.invokeMethod("getInstalledUpiApps");
  }

  static Future<bool> launchApp({
    required String packageName,
    required String url,
  }) async {
    return await _channel.invokeMethod(
      "launchUpiApp",
      {
        "packageName": packageName,
        "url": url,
      },
    );
  }
}