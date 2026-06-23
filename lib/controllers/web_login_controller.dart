
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/domain/usecase/web_login_usecase.dart';
import 'package:maxpay/core/domain/usecase/web_logout_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class WebLoginController extends GetxController {
  final WebLoginUsecase webloginusecase;
  final WebLogoutUsecase webLogoutUsecase;

  WebLoginController({
    required this.webloginusecase,
    required this.webLogoutUsecase,
  });

  RxBool isLoading = false.obs;
RxBool isScanned = false.obs;
  RxString scannedUserId = ''.obs;

  Future<void> submitLogin() async {
    if (scannedUserId.value.isEmpty) {
      CustomToast.error("Please scan QR first");
      return;
    }

    try {
      isLoading.value = true;

      final result = await webloginusecase(
        scannedUserId.value,
      );

      result.fold(
        (failure) {
          CustomToast.error(failure.message);
        },
        (response) {
          CustomToast.success(
            response.message ?? "Web Login Success",
          );

          Get.back();
        },
      );
    } catch (e) {
      CustomToast.error(e.toString());
    } finally {
      isLoading.value = false;
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