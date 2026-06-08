import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/domain/usecase/create_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/finger_print_usecase.dart';
import 'package:maxpay/core/domain/usecase/login_usecase.dart';
import 'package:maxpay/core/domain/usecase/otp_usecase.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

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
  final LocalStorageService storage = LocalStorageService();
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

      AppLogger.logError("FULL API RESPONSE :");
      AppLogger.logError(result);

      result.fold(
        (failure) {
          AppLogger.logError("FAILURE MESSAGE:");
          AppLogger.logError(failure.message);

          CustomToast.error(failure.message);
        },

        (response) {
          /// PRINT COMPLETE RESPONSE
          AppLogger.logError("============== LOGIN RESPONSE ==============");

          AppLogger.logError("SUCCESS : ${response.success}");

          AppLogger.logError("MESSAGE : ${response.message}");

          AppLogger.logError("OTP : ${response.data?.otp}");

          AppLogger.logError("PHONE NUMBER : ${response.data?.phoneNumber}");

          AppLogger.logError("NAME : ${response.data?.name}");

          AppLogger.logError("PINCODE : ${response.data?.pincode}");

          AppLogger.logError("============================================");

          if (response.success != true) {
            AppLogger.logError("Retailer not found. Contact admin.");

            CustomToast.error(response.message ?? "Login Failed");

            return;
          }

          otp.value = response.data?.otp?.toString() ?? "";

          phoneNumber.value = response.data?.phoneNumber ?? "";

          AppLogger.logError("OTP : ${otp.value}");
          AppLogger.logError("PHONE : ${phoneNumber.value}");

          Get.toNamed(AppRoutes.otpVerification);
        },
      );
    } catch (e) {
      AppLogger.logError("EXCEPTION:");
      AppLogger.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String enteredOtp) async {
    try {
      isLoading.value = true;

      final result = await otpUsecase(phoneNumber.value, enteredOtp);

      result.fold(
        (failure) {
          AppLogger.logError("FAILURE MESSAGE : ${failure.message}");

          CustomToast.error(failure.message);
        },

        (response) async {
          AppLogger.logError(
            "============== OTP VERIFY RESPONSE ==============",
          );
          AppLogger.logError("SUCCESS : ${response.success}");
          AppLogger.logError("MESSAGE : ${response.message}");
          AppLogger.logError("CODE : ${response.code}");
          AppLogger.logError("USER ID : ${response.data?.userId}");
          AppLogger.logError("TOKEN : ${response.data?.token}");
          AppLogger.logError(
            "=================================================",
          );

          if (response.success == true) {
            /// SAVE TOKEN
            await storage.saveString("auth_token", response.data?.token ?? "");

            /// SAVE USER ID
            await storage.saveInt("user_id", response.data?.userId ?? 0);

            AppLogger.logError("TOKEN SAVED SUCCESSFULLY");

            CustomToast.success(response.message ?? "OTP Verified");

            if (response.data?.isFingerPrint == 1) {
              final LocalAuthentication auth = LocalAuthentication();
              try {
                bool authenticated = await auth.authenticate(
                  localizedReason: 'Scan your fingerprint to continue',
                  biometricOnly: true,
                  persistAcrossBackgrounding: true,
                );

                if (authenticated) {
                  Get.offAllNamed(AppRoutes.main);
                } else {
                  CustomToast.error("Fingerprint authentication failed");
                }
              } catch (e) {
                AppLogger.logError("Fingerprint error: $e");
                CustomToast.error("Biometrics error: ${e.toString()}");
              }
            } else {
              Get.offAllNamed(AppRoutes.biometricsIntro);
            }
          } else {
            CustomToast.error(response.message ?? "Invalid OTP");
          }
        },
      );
    } catch (e) {
      AppLogger.logError(e.toString());

      CustomToast.error(e.toString());
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
          CustomToast.error(failure.message);
        },

        (response) {
          if (response.success == true) {
            otp.value = response.data?.otp?.toString() ?? "";

            phoneNumber.value = response.data?.phoneNumber ?? "";

            AppLogger.logError("NEW OTP : ${otp.value}");

            CustomToast.success("OTP Resent Successfully");
          } else {
            CustomToast.error(response.message ?? "Failed");
          }
        },
      );
    } catch (e) {
      CustomToast.error(e.toString());
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
          AppLogger.logError("=========== CREATE PIN RESPONSE ===========");
          AppLogger.logError("SUCCESS : ${response.success}");
          AppLogger.logError("MESSAGE : ${response.message}");
          AppLogger.logError("===========================================");

          if (response.success == true) {
            CustomToast.success(response.message ?? "PIN Created Successfully");

            Get.offAllNamed(AppRoutes.successScreen);
          } else {
            CustomToast.error(response.message ?? "Failed to create PIN");
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

      final result = await fingerPrintUsecase(fingerprint);

      result.fold(
        (failure) {
          AppLogger.logError("FINGERPRINT FAILURE : ${failure.message}");

          CustomToast.error(failure.message);
        },

        (response) async {
          AppLogger.logError("=========== FINGERPRINT RESPONSE ===========");

          AppLogger.logError("👍SUCCESS : ${response.success}");

          AppLogger.logError("MESSAGE : ${response.message}");

          AppLogger.logError("===========================================");

          if (response.success == true) {
            CustomToast.success(
              response.message ?? "Fingerprint Updated Successfully",
            );

            Get.offAllNamed(AppRoutes.successScreen);
          } else {
            CustomToast.error(response.message ?? "Fingerprint Update Failed");
          }
        },
      );
    } catch (e) {
      AppLogger.logError("FINGERPRINT EXCEPTION : $e");

      CustomToast.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      final result = await loginUseCase.repository.logout();

      result.fold(
        (failure) {
          AppLogger.logError("Logout FAILURE : ${failure.message}");

          CustomToast.error(failure.message);
        },

        (response) async {
          AppLogger.logError("=========== Logout RESPONSE ===========");

          AppLogger.logError("👍SUCCESS : $response");

          AppLogger.logError("===========================================");

          if (response['success'] == true) {
            CustomToast.success("Logout Successfully");

            await storage.remove("auth_token");
            await storage.remove("user_id");

            Get.offAllNamed(AppRoutes.loginPhoneName);
            Get.find<NavbarController>().setIndex(0);
          } else {
            CustomToast.error("Logout Failed");
          }
        },
      );
    } catch (e) {
      AppLogger.logError("FINGERPRINT EXCEPTION : $e");

      CustomToast.error(e.toString());
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
