import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:maxpay/controllers/login_history_controller.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/domain/usecase/create_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/finger_print_usecase.dart';
import 'package:maxpay/core/domain/usecase/login_usecase.dart';
import 'package:maxpay/core/domain/usecase/otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/verify_pin_usecase.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/device_info.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/sim_util.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final OtpUsecase otpUsecase;
  final CreatePinUsecase createPinUsecase;
  final FingerPrintUsecase fingerPrintUsecase;
  final VerifyPinUsecase verifyPinUsecase;

  AuthController({
    required this.loginUseCase,
    required this.otpUsecase,
    required this.createPinUsecase,
    required this.fingerPrintUsecase,
    required this.verifyPinUsecase,
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
  RxInt isNewUser = 0.obs;
  RxInt isPin = 0.obs;
  RxInt isFingerPrint = 0.obs;
  RxBool isNewUserFlow = false.obs;
  final LocalStorageService storage = LocalStorageService();
  @override
  void onInit() {
    super.onInit();
    loadLocalSession();
  }

  Future<void> loadLocalSession() async {
    await storage.init();

    isPin.value = storage.getInt("is_pin") ?? 0;
    isFingerPrint.value = storage.getInt("is_fingerprint") ?? 0;

    AppLogger.logError("LOADED FINGERPRINT => ${isFingerPrint.value}");
  }

  // Login API Call
  Future<void> login() async {
    try {
      isLoading.value = true;

      final enteredPhone = phoneController.text.trim();

      final result = await loginUseCase(
        enteredPhone,
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

          if (SimUtil.testNumbers.contains(enteredPhone)) {
            CustomToast.success("OTP: ${otp.value}");
          }
          Get.toNamed(
            AppRoutes.otpVerification,
            arguments: {"phone": phoneNumber.value},
          );
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

      await result.fold(
        (failure) async {
          CustomToast.error(failure.message);
        },
        (response) async {
          AppLogger.logError("========== OTP RESPONSE ==========");
          AppLogger.logError("SUCCESS => ${response.success}");
          AppLogger.logError("MESSAGE => ${response.message}");

          AppLogger.logError("USER_ID => ${response.data?.userId}");
          AppLogger.logError("IS_NEW_USER => ${response.data?.isNewUser}");
          AppLogger.logError("IS_PIN => ${response.data?.isPin}");
          AppLogger.logError(
            "IS_FINGER_PRINT => ${response.data?.isFingerPrint}",
          );
          AppLogger.logError("TOKEN => ${response.data?.token}");
          AppLogger.logError("================================");

          if (response.success == true) {
            final deviceInfo = await DeviceInfoService.getInfo();

            await storage.saveString("ip_address", deviceInfo["ip"] ?? "");

            await storage.saveString("city", deviceInfo["city"] ?? "");

            await storage.saveString("state", deviceInfo["state"] ?? "");

            await storage.saveString("network", deviceInfo["network"] ?? "");

            AppLogger.logError("IP => ${storage.getString("ip_address")}");

            AppLogger.logError("CITY => ${storage.getString("city")}");

            AppLogger.logError("STATE => ${storage.getString("state")}");

            AppLogger.logError("NETWORK => ${storage.getString("network")}");
            await storage.saveString("auth_token", response.data?.token ?? "");
            await storage.saveString("logged_in_phone", phoneNumber.value);

            await storage.saveInt("user_id", response.data?.userId ?? 0);

            final newUser = response.data?.isNewUser ?? 0;
            final pin = response.data?.isPin ?? 0;
            final fp = response.data?.isFingerPrint ?? 0;

            isNewUser.value = newUser;
            isPin.value = pin;
            isFingerPrint.value = fp;

            await storage.saveInt("is_new_user", newUser);
            await storage.saveInt("is_pin", pin);
            await storage.saveInt("is_fingerprint", fp);
            AppLogger.logError("isNewUser : ${response.data?.isNewUser}");

            AppLogger.logError("isPin : ${response.data?.isPin}");

            AppLogger.logError(
              "isFingerPrint : ${response.data?.isFingerPrint}",
            );
            await storage.saveString("auth_token", response.data?.token ?? "");

            await storage.saveInt("user_id", response.data?.userId ?? 0);

            await storage.saveInt("is_pin", response.data?.isPin ?? 0);

            await storage.saveInt(
              "is_fingerprint",
              response.data?.isFingerPrint ?? 0,
            );

            AppLogger.logError("TOKEN => ${storage.getString("auth_token")}");

            AppLogger.logError("IS_PIN => ${storage.getInt("is_pin")}");

            AppLogger.logError(
              "IS_FINGERPRINT => ${storage.getInt("is_fingerprint")}",
            );

            if (pin == 1) {
              Get.offAllNamed(AppRoutes.veirfypin);
            } else {
              isNewUserFlow.value = true;
              Get.offAllNamed(AppRoutes.pinCodeCreation);
            }
          } else {
            CustomToast.error(response.message ?? "OTP Failed");
          }
        },
      );
    } catch (e) {
      CustomToast.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> authenticateWithFingerprint() async {
    try {
      final LocalAuthentication auth = LocalAuthentication();

      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to continue',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );

      if (authenticated) {
        await storage.saveString(
          "last_active_time",
          DateTime.now().toIso8601String(),
        );
        final historyController = Get.put(
          LoginHistoryController(loginHistoryUsecase: sl()),
        );

        historyController.fromDate = DateTime.now().toString().split(' ')[0];

        historyController.toDate = DateTime.now().toString().split(' ')[0];

        historyController.search = "";

        await historyController.LoginHistory();

        Get.offAllNamed(AppRoutes.main);
      } else {
        CustomToast.error("Fingerprint authentication failed");
      }
    } on LocalAuthException catch (e) {
      // CustomToast.error(e.toString());
      AppLogger.logError("FINGERPRINT AUTHENTICATION ERROR : ${e.toString()}");
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
            if (SimUtil.testNumbers.contains(phoneController.text.trim())) {
              CustomToast.success("OTP: ${otp.value}");
            }
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

      AppLogger.logError("=========== CREATE MPIN REQUEST ===========");
      AppLogger.logError("PIN => $pin");
      AppLogger.logError("USER_ID => ${storage.getInt("user_id")}");
      AppLogger.logError("IS_PIN BEFORE API => ${storage.getInt("is_pin")}");
      AppLogger.logError("=========================================");

      final result = await createPinUsecase(pin);

      result.fold(
        (failure) {
          AppLogger.logError("CREATE MPIN FAILURE");
          AppLogger.logError(failure.message);

          CustomToast.error(failure.message);
        },

        (response) async {
          AppLogger.logError("=========== CREATE MPIN RESPONSE ===========");
          AppLogger.logError("SUCCESS : ${response.success}");
          AppLogger.logError("MESSAGE : ${response.message}");
          AppLogger.logError("IS_PIN STORAGE : ${storage.getInt("is_pin")}");
          AppLogger.logError("===========================================");

          if (response.success == true) {
            await storage.saveInt("is_pin", 1);
            await storage.saveString(
              "last_active_time",
              DateTime.now().toIso8601String(),
            );

            AppLogger.logError("IS_PIN SAVED => ${storage.getInt("is_pin")}");

            Get.offAllNamed(
              AppRoutes.successScreen,
              arguments: {
                "title": "Pin Created Successfully",
                "message": "Your 6 digit pin has been created successfully",
              },
            );
          } else {
            AppLogger.logError("PIN CREATION FAILED => ${response.message}");

            CustomToast.error(response.message ?? "Failed");
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyPin(String pin) async {
    try {
      isLoading.value = true;

      AppLogger.logError("=========== VERIFY PIN REQUEST ===========");
      AppLogger.logError("PIN ENTERED: $pin");

      final result = await verifyPinUsecase(pin);

      return await result.fold(
        (failure) async {
          AppLogger.logError("VERIFY PIN FAILURE:");
          AppLogger.logError(failure.message);

          CustomToast.error(failure.message);
          return false;
        },
        (response) async {
          AppLogger.logError("=========== RAW RESPONSE ===========");
          AppLogger.logError("SUCCESS: ${response.success}");
          AppLogger.logError("MESSAGE: ${response.message}");
          AppLogger.logError("DATA: ${response.data}");
          AppLogger.logError("====================================");
          AppLogger.logError("=========== VERIFY PIN RESPONSE ===========");
          AppLogger.logError("SUCCESS: ${response.success}");
          AppLogger.logError("MESSAGE: ${response.message}");

          // if (response.success == true) {
          //   CustomToast.success(response.message ?? "PIN Verified");

          //   AppLogger.logError("PIN VERIFIED SUCCESSFULLY");
          //   await storage.saveString(
          //     "last_active_time",
          //     DateTime.now().toIso8601String(),
          //   );

          //   Get.offAllNamed(AppRoutes.main);

          //   return true;
          // } else {
          //   CustomToast.error(response.message ?? "Invalid PIN");

          //   AppLogger.logError("INVALID PIN ENTERED");

          //   return false;
          // }

          if (response.success == true) {
            CustomToast.success(response.message ?? "PIN Verified");

            AppLogger.logError("PIN VERIFIED SUCCESSFULLY");

            await storage.saveString(
              "last_active_time",
              DateTime.now().toIso8601String(),
            );

            final historyController = Get.put(
              LoginHistoryController(loginHistoryUsecase: sl()),
            );

            historyController.fromDate = DateTime.now().toString().split(
              ' ',
            )[0];

            historyController.toDate = DateTime.now().toString().split(' ')[0];

            historyController.search = "";

            await historyController.LoginHistory();

            Get.offAllNamed(AppRoutes.main);

            return true;
          } else {
            CustomToast.error(response.message ?? "Invalid PIN");

            AppLogger.logError("INVALID PIN ENTERED");

            return false;
          }
        },
      );
    } catch (e) {
      AppLogger.logError("VERIFY PIN EXCEPTION:");
      AppLogger.logError(e.toString());

      CustomToast.error(e.toString());
      return false;
    } finally {
      isLoading.value = false;
      AppLogger.logError("VERIFY PIN LOADING STOPPED");
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
            await storage.saveInt(
              "is_fingerprint",
              response.data?.isFingerPrint ?? 0,
            );

            isFingerPrint.value = response.data?.isFingerPrint ?? 0;
            CustomToast.success(
              response.message ?? "Fingerprint Updated Successfully",
            );

            // Get.offAllNamed(AppRoutes.successScreen);
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
            await storage.remove("last_active_time");
            phoneController.clear();

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

  /// Forces a complete local logout and attempts to call the backend logout API.
  /// This ensures that even if the API fails (e.g. no internet), local tokens are wiped securely.
  Future<void> forceLogout() async {
    try {
      AppLogger.logError("Attempting forced backend logout...");
      await loginUseCase.repository.logout();
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

  @override
  void onClose() {
    phoneController.dispose();
    nameController.dispose();
    pincodeController.dispose();
    super.onClose();
  }
}
