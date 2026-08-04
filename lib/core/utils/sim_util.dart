import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_card_code/sim_card_code.dart';
import 'package:flutter/services.dart';

class SimUtil {
  /// Test numbers exception list
  static const List<String> testNumbers = [
    '9999999999',
    '6369497198',
    '9895762284',
    '6369497196',
    '8888444444'
  ];

  /// Helper function to normalize and match
  static bool _matches(String entered, String? sim) {
    if (sim == null || sim.isEmpty) return false;
    final cleanEntered = entered.replaceAll(RegExp(r'\D'), '');
    final cleanSim = sim.replaceAll(RegExp(r'\D'), '');
    if (cleanEntered.isEmpty || cleanSim.isEmpty) return false;

    
    if (cleanEntered.length >= 10 && cleanSim.length >= 10) {
      return cleanEntered.substring(cleanEntered.length - 10) ==
          cleanSim.substring(cleanSim.length - 10);
    }

  
    if (cleanEntered.endsWith(cleanSim)) {
      return true;
    }

    return cleanEntered == cleanSim;
  }

  /// Verifies if the [registeredPhone] is currently present in the device's SIM slots.
  /// Returns [true] if:
  /// 1. The phone is in the test numbers list.
  /// 2. The phone matches an active SIM.
  /// 3. SIMs are present but none return a readable phone number (fallback).
  /// Returns [false] if:
  /// 1. Permission is denied.
  /// 2. No SIM is inserted.

  /// 3. The phone number doesn't match any of the readable SIMs.
  /// Set [showToasts] to true to display error messages via CustomToast (e.g. during login).
  static const _simChannel = MethodChannel('sim_verification');

  /// Verifies if the [registeredPhone] is currently present in the device's SIM slots.
 
  static Future<bool> verifySimPresent(
    String registeredPhone, {
    bool showToasts = false,
  }) async {
    final enteredPhone = registeredPhone.trim();

    if (testNumbers.contains(enteredPhone)) {
      return true; 
    }


    var status = await Permission.phone.status;
    if (!status.isGranted && !status.isLimited) {
      status = await Permission.phone.request();
    }

    if (!status.isGranted && !status.isLimited) {
      if (showToasts) {
        CustomToast.error(
          "Phone permission is required to verify the SIM card",
        );
      }
      return false;
    }
    try {
      final List<dynamic>? simList = await _simChannel.invokeMethod(
        'getSimList',
      );
      AppLogger.logError("Detected SIM cards via channel: ${simList?.length ?? 0}");

      if (simList == null || simList.isEmpty) {
        if (showToasts) {
          CustomToast.error("No SIM card detected in this device");
        }
        return false;
      }

      int readableSimsCount = 0;
      bool numberMatched = false;

      for (var sim in simList) {
        final Map<dynamic, dynamic> simData = sim as Map<dynamic, dynamic>;
        final String? phoneNumber = simData['number']?.toString().trim();

        AppLogger.logError(
          "SIM slot=${simData['slotIndex']}, carrier=${simData['carrierName']}, number=$phoneNumber",
        );

        if (phoneNumber != null && phoneNumber.isNotEmpty) {
          readableSimsCount++;
          if (_matches(enteredPhone, phoneNumber)) {
            numberMatched = true;
            break;
          }
        }
      }

      // If we found a direct match on any readable SIM, permit immediately.
      if (numberMatched) {
        AppLogger.logError("SIM check passed: Phone number matched active SIM.");
        return true;
      }

      // If NOT all inserted SIMs returned readable numbers (e.g. carrier did not store MSISDN on SIM hardware),
      // we allow the login/session to proceed because at least one active SIM card exists whose number cannot be read by Android OS.
      // Ownership is then securely verified through OTP / SMS.
      final int totalSimsCount = simList.length;
      if (readableSimsCount < totalSimsCount) {
        AppLogger.logError(
          "SIM check fallback: $readableSimsCount of $totalSimsCount SIMs returned readable numbers. Permitting operation.",
        );
        return true;
      }

      // If ALL inserted SIMs returned readable phone numbers and NONE of them matched the entered phone:
      AppLogger.logError(
        "SIM check failed: None of the $totalSimsCount readable SIM cards matched $enteredPhone.",
      );
      if (showToasts) {
        CustomToast.error(
          "The entered mobile number does not exist on this device",
        );
      }
      return false;
    } catch (e) {
      AppLogger.logError("Failed to get SIM list via channel: $e");
      if (showToasts) {
        CustomToast.error("Failed to verify SIM card");
      }
      return false;
    }
  }

  /// Old implementation of verifySimPresent using sim_card_code package.
  /// Kept here for easy reversion.
  static Future<bool> verifySimPresentOld(
    String registeredPhone, {
    bool showToasts = false,
  }) async {
    final enteredPhone = registeredPhone.trim();

    if (testNumbers.contains(enteredPhone)) {
      return true; // Bypass for test numbers
    }

    // 1. Request phone permission
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    if (!status.isGranted) {
      if (showToasts) {
        CustomToast.error(
          "Phone permission is required to verify the SIM card",
        );
      }
      return false;
    }

    // 2. Fetch SIM info
    final sims = await SimCardManager.allSimInfo;
    AppLogger.logError("Detected SIM cards: ${sims.length}");

    if (sims.isEmpty) {
      if (showToasts) {
        CustomToast.error("No SIM card detected in this device");
      }
      return false;
    }

    bool numberExists = false;

    for (var sim in sims) {
      AppLogger.logError(
        "SIM slot=${sim.slotIndex}, carrier=${sim.carrierName}, number=${sim.phoneNumber}",
      );
      if (sim.phoneNumber != null && sim.phoneNumber!.isNotEmpty) {
        if (_matches(enteredPhone, sim.phoneNumber)) {
          numberExists = true;
          break;
        }
      }
    }

    // Also check the default phoneNumber getter
    final defaultNumber = await SimCardManager.phoneNumber;
    AppLogger.logError("Default SIM phone number: $defaultNumber");
    if (defaultNumber != null && defaultNumber.isNotEmpty) {
      if (_matches(enteredPhone, defaultNumber)) {
        numberExists = true;
      }
    }

    // Strictly block if a number isn't found
    if (!numberExists) {
      if (showToasts) {
        CustomToast.error(
          "The entered mobile number does not exist on this device",
        );
      }
      return false;
    }

    return true;
  }
}
