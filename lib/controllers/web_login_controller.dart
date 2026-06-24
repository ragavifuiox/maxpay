
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/domain/usecase/web_login_usecase.dart';
import 'package:maxpay/core/domain/usecase/web_logout_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/view/weblogin/qr_success_screen.dart';

class WebLoginController extends GetxController {
  final WebLoginUsecase webloginusecase;
  final WebLogoutUsecase webLogoutUsecase;

  WebLoginController({
    required this.webloginusecase,
    required this.webLogoutUsecase,
  });
  RxBool isScanned = false.obs;
  RxString scannedUserId = ''.obs;

@override
void onReady() {
  super.onReady();

  isScanned.value = false;
  scannedUserId.value = '';
}
  RxBool isLoading = false.obs;
void resetScanner() {
    isScanned.value = false;
    scannedUserId.value = '';
  }

Future<void> submitLogin() async {
  print("===== SUBMIT LOGIN START =====");
  print("Scanned User ID: ${scannedUserId.value}");

  if (scannedUserId.value.isEmpty) {
    print("ERROR: QR is empty");
    CustomToast.error("Please scan QR first");
    return;
  }

  try {
    isLoading.value = true;
    print("Loading started...");

    final result = await webloginusecase(scannedUserId.value);

    print("API CALLED");

    result.fold(
      (failure) {
        print("FOLD => FAILURE");
        print("Error Message: ${failure.message}");

        CustomToast.error(failure.message);
      },
      (response) {
        print("FOLD => SUCCESS RESPONSE RECEIVED");
        print("Response success: ${response.success}");
        print("Response message: ${response.message}");
        print("Full response: $response");

        if (response.success == true) {
          print("LOGIN SUCCESS BLOCK");
          CustomToast.success(response.message ?? "Web Login Success");

          print("Navigating to Success Screen...");
         Get.offAllNamed(AppRoutes.setting);
        } else {
          print("LOGIN FAILED BLOCK");
          CustomToast.error(response.message ?? "Login failed");
        }
      },
    );
  } catch (e) {
    print("EXCEPTION OCCURRED");
    print("Error: $e");

    CustomToast.error(e.toString());
  } finally {
    isLoading.value = false;
    print("Loading stopped");
    print("===== SUBMIT LOGIN END =====");
  }
}
Future<void> WebLogout({
  required String isweb,
  
}) async {
  try {
    isLoading.value = true;

    final result = await webLogoutUsecase(
     isweb
    );

    AppLogger.debugPrint("API CALLED SUCCESSFULLY");

    result.fold(
      (failure) {

        // ❌ ERROR TOAST
        CustomToast.error(
          failure.message.toString(),
        );

        debugPrint("ERROR: ${failure.message}");
      },

           (response) {
        // ✅ SUCCESS TOAST
        CustomToast.success(
          response.message ?? "web logout Successfully",
        );

        debugPrint("SUCCESS RESPONSE: ${response.toJson()}");
      },
    );
  } catch (e) {

    // 🔥 EXCEPTION TOAST
    CustomToast.error(e.toString());

    debugPrint("EXCEPTION: $e");
  } finally {
    isLoading.value = false;
  }
}

  
}