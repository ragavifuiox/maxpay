import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:maxpay/core/constants/routes_path.dart';

class NetworkService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? subscription;

  bool _isOffline = false;

  Future<NetworkService> init() async {
    print("🤔 NetworkService: Initializing...");

    subscription = _connectivity.onConnectivityChanged.listen((results) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;
      print("📡 Connectivity changed -> $result");
      _checkInternet(result);
    });

    // Initial check after UI builds
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final results = await _connectivity.checkConnectivity();
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;
      print("🌐 Initial connectivity -> $result");
      _checkInternet(result);
    });

    return this;
  }

  // 🔍 Real internet check
  Future<bool> _hasInternet(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      return false; // Fast fail if no physical connection
    }
    try {
      final lookupResult = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3)); // Add timeout to prevent hanging
      final hasNet =
          lookupResult.isNotEmpty && lookupResult[0].rawAddress.isNotEmpty;
      print("🌍 Internet check -> $hasNet");
      return hasNet;
    } catch (e) {
      print("❌ Internet check failed -> $e");
      return false;
    }
  }

  // 🚀 Main logic
  Future<void> checkInternetNow() async {
    final results = await _connectivity.checkConnectivity();
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    await _checkInternet(result);
  }

  int _checkCounter = 0;

  Future<void> _checkInternet(ConnectivityResult result) async {
    final currentCheck = ++_checkCounter;

    bool hasInternet = await _hasInternet(result);

    // If a newer check has started, discard this result
    if (_checkCounter != currentCheck) return;

    // ❌ NO INTERNET
    if (!hasInternet) {
      _isOffline = true;
      print("🚫 No Internet");

      // Prevent multiple pushes if already on the screen
      if (Get.currentRoute != AppRoutes.noInternet) {
        Get.toNamed(AppRoutes.noInternet);
      }
    }
    // ✅ INTERNET RESTORED
    else {
      if (_isOffline) {
        _isOffline = false;
        print("✅ Internet Restored");
      }

      // Always ensure the screen is closed if we have internet and happen to be on it
      if (Get.currentRoute == AppRoutes.noInternet) {
        Get.back();
      }
    }
  }

  @override
  void onClose() {
    print("🧹 NetworkService disposed");
    subscription?.cancel();
    super.onClose();
  }
}
