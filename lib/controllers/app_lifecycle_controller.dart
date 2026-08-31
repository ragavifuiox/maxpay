import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class AppLifecycleController extends GetxController
    with WidgetsBindingObserver {
  static const String _keyLastActive = "last_active_time";

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  /// Returns true if the time interval between [lastActive] and [current]
  /// crosses at least one daily boundary: 6:00 AM, 12:00 PM, 6:00 PM, or 12:00 AM (00:00).
  static bool hasCrossedLogoutTime(DateTime lastActive, DateTime current) {
    if (current.difference(lastActive).inHours >= 24) {
      return true;
    }

    final datesToCheck = [
      DateTime(lastActive.year, lastActive.month, lastActive.day),
      DateTime(current.year, current.month, current.day),
    ];

    // Fixed daily boundary hours: 12 AM (0), 6 AM (6), 12 PM (12), 6 PM (18)
    final hours = [0, 6, 12, 18];

    for (final date in datesToCheck) {
      for (final hour in hours) {
        final boundary = DateTime(date.year, date.month, date.day, hour);
        // If a boundary time occurred after lastActive and before or at current,
        // it means we have crossed a logout boundary.
        if (boundary.isAfter(lastActive) && !boundary.isAfter(current)) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    AppLogger.logError("AppLifecycleState changed to: $state");

    final storage = LocalStorageService();
    await storage.init();

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // Save last active time when the app goes into the background
      await storage.saveString(
        _keyLastActive,
        DateTime.now().toIso8601String(),
      );
      AppLogger.logError(
        "Saved last active time: ${DateTime.now().toIso8601String()}",
      );
    } else if (state == AppLifecycleState.resumed) {
      final token = storage.getString("auth_token");
      final loggedInPhone = storage.getString("logged_in_phone");

      if (token != null &&
          token.isNotEmpty &&
          loggedInPhone != null &&
          loggedInPhone.isNotEmpty) {
        final lastTimeStr = storage.getString("last_active_time");
        if (lastTimeStr != null && lastTimeStr.isNotEmpty) {
          final lastTime = DateTime.parse(lastTimeStr);
          final diff = DateTime.now().difference(lastTime).inMinutes;

          if (diff >= 3) {
            AppLogger.logError(
              "Session expired (diff: $diff min). Redirecting to verify pin...",
            );
            storage.remove("last_active_time");

            if (storage.getInt("is_pin") == 1) {
              Get.offAllNamed(AppRoutes.veirfypin);
            } else {
              Get.offAllNamed(AppRoutes.pinCodeCreation);
            }
          }
        }
      }

      final isPin = storage.getInt("is_pin") ?? 0;
      final isFingerPrint = storage.getInt("is_fingerprint") ?? 0;

      if (token != null && token.isNotEmpty && isPin == 1) {
        final lastActiveStr = storage.getString(_keyLastActive);
        if (lastActiveStr != null) {
          final lastActive = DateTime.tryParse(lastActiveStr);
          if (lastActive != null) {
            final crossed = hasCrossedLogoutTime(lastActive, DateTime.now());
            AppLogger.logError(
              "App resumed. Last active: $lastActive, Current: ${DateTime.now()}. Crossed boundary: $crossed",
            );

            if (crossed) {
              final currentRoute = Get.currentRoute;
              final authRoutes = [
                AppRoutes.splash,
                AppRoutes.intro,
                AppRoutes.welcome,
                AppRoutes.loginPhoneName,
                AppRoutes.otpVerification,
                AppRoutes.biometricsIntro,
                AppRoutes.biometricsScanning,
                AppRoutes.pinCodeCreation,
                AppRoutes.enterPin,
                AppRoutes.veirfypin,
              ];

              if (!authRoutes.contains(currentRoute)) {
                AppLogger.logError(
                  "Logout boundary crossed. Navigating to PIN/Biometric verification screen.",
                );
                if (isFingerPrint == 1) {
                  Get.offAllNamed(AppRoutes.veirfypin);
                } else {
                  Get.offAllNamed(AppRoutes.enterPin);
                }
              }
            }
          }
        }
      }
    }
  }
}
