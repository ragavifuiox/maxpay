import 'dart:async';

import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/update_otp_model.dart';
import 'package:maxpay/core/data/model/update_send_otmodel.dart';
import 'package:maxpay/core/domain/usecase/update_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_send_otp_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/view/login/login_phone_name.dart';

class UpdatePinController extends GetxController {
  final UpdatePinUsecase updatepinusecase;
 final UpdateSendOtpUsecase updateSendOtpUsecase;
 final UpdateOtpUsecase updateotpusecase;
  UpdatePinController({
    required this.updatepinusecase,
    required this.updateSendOtpUsecase,
    required this.updateotpusecase,
    
  });
 Rxn<UpdateOtp> updateOtpResponse = Rxn<UpdateOtp>();
  RxBool isLoading = false.obs;
 Rx<SendUpdatePinOtpResponse?> otpResponse =
      Rx<SendUpdatePinOtpResponse?>(null);

RxInt remainingSeconds = 60.obs;
RxBool canResendOtp = false.obs;

Timer? _timer;
     Future<void> sendUpdatePinOtp() async {
  try {
    isLoading.value = true;

    final result = await updateSendOtpUsecase();

    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (response) {
        otpResponse.value = response;

        CustomToast.success(
          response.message ?? "OTP sent successfully",
        );
   startOtpTimer(); // Start countdown
        Get.toNamed(
          AppRoutes.verify,
          arguments: true,
        );
      },
    );
  } finally {
    isLoading.value = false;
  }
}


 Future<bool> verifyOtp(String otp) async {
    try {
      isLoading.value = true;

      final result = await updateotpusecase(otp);
      return result.fold(
        (failure) {
          AppLogger.logError("OTP Verify Failed: ${failure.message}");
          return false;
        },
        (response) {
          updateOtpResponse.value = response;

          AppLogger.logError("OTP Verify Success");
          AppLogger.logError(response.message);

          return response.success == true;
        },
      );
    } catch (e) {
      AppLogger.logError("Controller Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> updatePin({
    required int newPin,
    required int confirmPin,
  }) async {
    isLoading.value = true;

    final result = await updatepinusecase(
       newPin.toString(),
      confirmPin.toString(),
    );

    isLoading.value = false;

    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (response) {
        if (response.success == true) {
          Get.to(LoginPhoneNamePage());
          CustomToast.success(
            response.message ?? "Pin Updated Successfully",
          );
        } else {
          CustomToast.error(
            response.message ?? "Failed to update pin",
          );
        }
      },
    );
  }


  void startOtpTimer() {
  _timer?.cancel();

  remainingSeconds.value = 60;
  canResendOtp.value = false;

  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (remainingSeconds.value > 0) {
      remainingSeconds.value--;
    } else {
      canResendOtp.value = true;
      timer.cancel();
    }
  });
}

void stopTimer() {
  _timer?.cancel();
}

@override
void onClose() {
  stopTimer();
  super.onClose();
}
}