import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/domain/usecase/create_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/finger_print_usecase.dart';
import 'package:maxpay/core/domain/usecase/login_usecase.dart';
import 'package:maxpay/core/domain/usecase/otp_usecase.dart';
import 'package:maxpay/core/services/local_storage_service.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final OtpUsecase otpUsecase;
  final CreatePinUsecase createPinUsecase;
  final FingerPrintUsecase fingerPrintUsecase;    

  AuthController({
    required this.loginUseCase,
    required this.otpUsecase,
    required this.createPinUsecase,
    required this.fingerPrintUsecase,
  });

  // Controllers
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final pincodeController = TextEditingController();
  RxString countryCode = "91".obs;
  // Loading
  RxBool isLoading = false.obs;
  RxBool isAccepted = false.obs;
RxString otp = ''.obs;
RxString phoneNumber = ''.obs;
  final LocalStorageService storage =
      LocalStorageService();
  // Login API Call
Future<void> login() async {
  try {
    isLoading.value = true;

   final result = await loginUseCase(
  phoneController.text.trim(),
  countryCode.value,
  nameController.text.trim(),
  pincodeController.text.trim(),
);

    print("FULL API RESPONSE :");
    print(result);

    result.fold(
      (failure) {

        print("FAILURE MESSAGE:");
        print(failure.message);

        CustomToast.error(
          failure.message,
        );
      },

      (response) {

        /// PRINT COMPLETE RESPONSE
       print("============== LOGIN RESPONSE ==============");

print("SUCCESS : ${response.success}");

print("MESSAGE : ${response.message}");

print("OTP : ${response.data?.otp}");

print("PHONE NUMBER : ${response.data?.phoneNumber}");

print("NAME : ${response.data?.name}");

print("PINCODE : ${response.data?.pincode}");

print("============================================");

        if (response.success != true) {

          print("Retailer not found. Contact admin.");

          CustomToast.error(
            response.message ?? "Login Failed",
          );

          return;
        }

        otp.value =
            response.data?.otp?.toString() ?? "";

        phoneNumber.value =
            response.data?.phoneNumber ?? "";

        print("OTP : ${otp.value}");
        print("PHONE : ${phoneNumber.value}");

        Get.toNamed(
          AppRoutes.otpVerification,
        );
      },
    );

  } catch (e) {

    print("EXCEPTION:");
    print(e.toString());

  } finally {

    isLoading.value = false;
  }
}

Future<void> verifyOtp(String enteredOtp) async {

  try {

    isLoading.value = true;

    final result = await otpUsecase(
      phoneNumber.value,
      enteredOtp,
    );

    result.fold(

      (failure) {

        print("FAILURE MESSAGE : ${failure.message}");

        CustomToast.error(
          failure.message,
        );
      },

      (response) async {

        print("============== OTP VERIFY RESPONSE ==============");
        print("SUCCESS : ${response.success}");
        print("MESSAGE : ${response.message}");
        print("CODE : ${response.code}");
        print("USER ID : ${response.data?.userId}");
        print("TOKEN : ${response.data?.token}");
        print("=================================================");

        if (response.success == true) {

          /// SAVE TOKEN
          await storage.saveString(
  "auth_token",
  response.data?.token ?? "",
);

          /// SAVE USER ID
          await storage.saveInt(
            "user_id",
            response.data?.userId ?? 0,
          );

          print("TOKEN SAVED SUCCESSFULLY");

          CustomToast.success(
            response.message ?? "OTP Verified",
          );

          Get.offAllNamed(
            AppRoutes.biometricsIntro,
          );

        } else {

          CustomToast.error(
            response.message ?? "Invalid OTP",
          );
        }
      },
    );

  } catch (e) {

    print(e.toString());

    CustomToast.error(
      e.toString(),
    );

  } finally {

    isLoading.value = false;
  }
}


Future<void> resendOtp() async {

  try {

    isLoading.value = true;

    final result = await loginUseCase(
  phoneController.text.trim(),
  countryCode.value,
  nameController.text.trim(),
  pincodeController.text.trim(),
);

    result.fold(

      (failure) {

        CustomToast.error(
          failure.message,
        );
      },

      (response) {

        if (response.success == true) {

          otp.value =
              response.data?.otp?.toString() ?? "";

          phoneNumber.value =
              response.data?.phoneNumber ?? "";

          print("NEW OTP : ${otp.value}");

          CustomToast.success(
            "OTP Resent Successfully",
          );

        } else {

          CustomToast.error(
            response.message ?? "Failed",
          );
        }
      },
    );

  } catch (e) {

    CustomToast.error(
      e.toString(),
    );

  } finally {

    isLoading.value = false;
  }
}

Future<void> createPin(String pin) async {
  try {
    isLoading.value = true;

    final result = await createPinUsecase(pin);

    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (response) async {

        print("=========== CREATE PIN RESPONSE ===========");
        print("SUCCESS : ${response.success}");
        print("MESSAGE : ${response.message}");
        print("===========================================");

        if (response.success == true) {

          CustomToast.success(
            response.message ?? "PIN Created Successfully",
          );

          Get.offAllNamed(AppRoutes.successScreen);

        } else {
          CustomToast.error(
            response.message ?? "Failed to create PIN",
          );
        }
      },
    );

  } finally {
    isLoading.value = false;
  }
}

Future<void> fingerprint(int fingerprint) async {

  try {

    isLoading.value = true;

    final result =
        await fingerPrintUsecase(
      fingerprint,
    );

    result.fold(

      (failure) {

        print(
          "FINGERPRINT FAILURE : ${failure.message}",
        );

        CustomToast.error(
          failure.message,
        );
      },

      (response) async {

        print(
            "=========== FINGERPRINT RESPONSE ===========");

        print(
          "👍SUCCESS : ${response.success}",
        );

        print(
          "MESSAGE : ${response.message}",
        );

        print(
            "===========================================");

        if (response.success == true) {

          CustomToast.success(
            response.message ??
                "Fingerprint Updated Successfully",
          );

          Get.offAllNamed(
            AppRoutes.successScreen,
          );

        } else {

          CustomToast.error(
            response.message ??
                "Fingerprint Update Failed",
          );
        }
      },
    );

  } catch (e) {

    print(
      "FINGERPRINT EXCEPTION : $e",
    );

    CustomToast.error(
      e.toString(),
    );

  } finally {

    isLoading.value = false;
  }
}

  @override
  void onClose() {
    phoneController.dispose();
    nameController.dispose();
    pincodeController.dispose();
    super.onClose();
  }
}