import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/core/domain/usecase/send_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/verify_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/create_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/verify_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/signup_send_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/logout_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_fingerprint_usecase.dart';

import 'package:local_auth/local_auth.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

class AuthController extends GetxController {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final CreatePinUseCase createPinUseCase;
  final VerifyPinUseCase verifyPinUseCase;
  final SignupSendOtpUseCase signupSendOtpUseCase;
  final LogoutUseCase logoutUseCase;
  final UpdateFingerprintUseCase updateFingerprintUseCase;

  AuthController({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.createPinUseCase,
    required this.verifyPinUseCase,
    required this.signupSendOtpUseCase,
    required this.logoutUseCase,
    required this.updateFingerprintUseCase,
  });

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final pincodeController = TextEditingController();
  final LocalStorageService storage = LocalStorageService();
  final isAccepted = false.obs;
  final isLoading = false.obs;
  final isVerifyLoading = false.obs;
  final isPinLoading = false.obs;
  final isVerifyPinLoading = false.obs;
  final isSignupLoading = false.obs;
  final countryCode = '91'.obs;
  final receivedOtp = ''.obs;

  final isMpin = 0.obs;
  final isFingerPrint = 0.obs;
  final LocalAuthentication auth = LocalAuthentication();
  final LocalStorageService _storage = LocalStorageService();

  void toggleAcceptance(bool? value) {
    isAccepted.value = value ?? false;
  }

  Future<void> login() async {
    if (!isAccepted.value) {
     CustomToast.error(
        'Please accept Terms of Service and Privacy Policy.',
      );
      return;
    }

    if (phoneController.text.isEmpty) {
      CustomToast.error("Please enter your phone number.");
      // Get.snackbar('Error', 'Please enter your phone number.');
      return;
    }

    isLoading.value = true;

    final result = await sendOtpUseCase(
      '+${countryCode.value}',
      phoneController.text,
    );

    result.fold(
      (failure) {
        isLoading.value = false;
        // Get.snackbar(
        //   'Error',
        CustomToast.error(
          failure.message,
         // snackPosition: SnackPosition.BOTTOM,
          // backgroundColor: Colors.redAccent,
          // colorText: Colors.white,
        );
      },
      (success) {
        isLoading.value = false;
        if (success.data?.otp != null) {
          receivedOtp.value = success.data!.otp.toString();
        }
        CustomToast.success(

          success.message ?? 'OTP sent successfully',
          // snackPosition: SnackPosition.BOTTOM,
          // backgroundColor: Colors.green,
          // colorText: Colors.white,
        );

        // Navigate to OTP verification page
        Get.toNamed(AppRoutes.otpVerification);
      },
    );
  }

  Future<void> signup() async {
    if (!isAccepted.value) {
    CustomToast.error(
        'Please accept Terms of Service and Privacy Policy.',
      );
      return;
    }

    if (phoneController.text.isEmpty) {
      CustomToast.error('Please enter your phone number.');
      return;
    }

    if (nameController.text.isEmpty) {
      CustomToast.error( 'Please enter your name.');
      return;
    }

    if (pincodeController.text.isEmpty) {
      CustomToast.error("Please enter your pincode");
      return;
    }

    isSignupLoading.value = true;

    final result = await signupSendOtpUseCase(
      '+${countryCode.value}',
      phoneController.text,
      nameController.text,
      pincodeController.text,
    );

    result.fold(
      (failure) {
        isSignupLoading.value = false;
       CustomToast.error(
          failure.message,

        );
      },
      (success) {
        isSignupLoading.value = false;
        if (success.data?.otp != null) {
          receivedOtp.value = success.data!.otp.toString();
        }
       CustomToast.success(
          success.message ?? 'OTP sent successfully for signup',

        );

        // Navigate to OTP verification page
        Get.toNamed(AppRoutes.otpVerification);
      },
    );
  }

  RxBool isNewUserFlow = false.obs;
  Future<void> verifyOtp(String otp) async {
    if (otp.length != 4) {
      CustomToast.error('Please enter a valid 4-digit OTP.');
      return;
    }

    isVerifyLoading.value = true;

    final result = await verifyOtpUseCase(phoneController.text, otp);

    result.fold(
      (failure) {
        isVerifyLoading.value = false;
        CustomToast.error(
          failure.message,

        );
      },
      (success) {
        isVerifyLoading.value = false;
        CustomToast.success(
          success.message ?? 'OTP verified successfully',

        );

        if (success.data?.token != null) {
          _storage.saveString('auth_token', success.data!.token!);
        }
        if (success.data?.userId != null) {
          _storage.saveString('user_id', success.data!.userId!.toString());
        }
        if (success.data?.phoneNumber != null) {
          _storage.saveString('logged_in_phone', success.data!.phoneNumber!);
        }

        final mpin = success.data?.isPin ?? 0;
        final fingerPrint = success.data?.isFingerPrint ?? 0;
        final isNewUser = success.data?.isNewUser ?? 0;

        _storage.saveInt('is_pin', mpin);
        _storage.saveInt('is_fingerprint', fingerPrint);
        _storage.saveInt('is_new_user', isNewUser);

        isMpin.value = mpin;
        isFingerPrint.value = fingerPrint;

        if (mpin == 1) {
          Get.offAllNamed(AppRoutes.veirfypin);
        } else {
          isNewUserFlow.value = true;
          Get.offAllNamed(AppRoutes.pinCodeCreation);
        }
      },
    );
  }

  Future<void> createPin(String pin) async {
    if (pin.length != 4) {
      CustomToast.error( 'Please enter a valid 4-digit PIN.');
      return;
    }

    isPinLoading.value = true;

    final result = await createPinUseCase(pin);

    result.fold(
      (failure) {
        isPinLoading.value = false;
       CustomToast.error(
          failure.message,

        );
      },
      (success) {
        isPinLoading.value = false;
        CustomToast.success(
          success.message ?? 'PIN created successfully',

        );

        storage.saveString(
          'last_active_time',
          DateTime.now().toIso8601String(),
        );

        // Navigate to success screen
        Get.toNamed(AppRoutes.successScreen);
      },
    );
  }

  Future<bool> verifyPin(String pin) async {
    if (pin.length != 4) {
     CustomToast.error( 'Please enter a valid 4-digit PIN.');
      return false;
    }

    isVerifyPinLoading.value = true;

    final result = await verifyPinUseCase(pin);

    return result.fold(
      (failure) {
        isVerifyPinLoading.value = false;
        CustomToast.error(
          failure.message,

        );
        return false;
      },
      (success) {
        isVerifyPinLoading.value = false;
        CustomToast.success(
          success.message ?? 'PIN verified successfully',

        );

        storage.saveString(
          'last_active_time',
          DateTime.now().toIso8601String(),
        );

        Get.offAllNamed(AppRoutes.main);
        return true;
      },
    );
  }

  Future<void> authenticateWithFingerprint() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      if (!canAuthenticate) {
        //Get.snackbar('Info', 'Biometrics not supported on this device.');
        CustomToast.error("Biometrics not supported on this device.");
        return;
      }

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        biometricOnly: true,
      );

      if (didAuthenticate) {
        storage.saveString(
          'last_active_time',
          DateTime.now().toIso8601String(),
        );
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (e) {
      CustomToast.error( 'Authentication failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      final result = await logoutUseCase();

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
            await storage.remove("last_active_time");
            phoneController.clear();

            Get.offAllNamed(AppRoutes.login);
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

  /// Forces a complete local logout and attempts to call the backend logout API.
  /// This ensures that even if the API fails (e.g. no internet), local tokens are wiped securely.
  Future<void> forceLogout() async {
    try {
      AppLogger.logError("Attempting forced backend logout...");
      await logoutUseCase();
    } catch (e) {
      AppLogger.logError("Forced backend logout failed: $e");
    } finally {
      // Regardless of API success, clear local tokens completely
      await storage.clear();
      phoneController.clear();

      AppLogger.logError("Local tokens completely wiped.");

      Get.offAllNamed(AppRoutes.intro);

      try {
        if (Get.isRegistered<NavbarController>()) {
          Get.find<NavbarController>().setIndex(0);
        }
      } catch (_) {}
    }
  }

  Future<void> toggleFingerprint(bool isEnabled) async {
    try {
      final status = isEnabled ? 1 : 0;
      final result = await updateFingerprintUseCase(status);
      result.fold(
        (failure) {
          CustomToast.error(failure.message);
        },
        (success) {
          isFingerPrint.value = status;
          storage.saveInt('is_fingerprint', status);
          CustomToast.success(
            success['message'] ?? 'Fingerprint updated successfully',
          );
        },
      );
    } catch (e) {
      CustomToast.error('Failed to update fingerprint settings');
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
