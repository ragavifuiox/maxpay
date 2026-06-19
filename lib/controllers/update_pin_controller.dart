import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/domain/usecase/update_pin_usecase.dart';
import 'package:maxpay/view/login/login_phone_name.dart';

class UpdatePinController extends GetxController {
  final UpdatePinUsecase updatepinusecase;

  UpdatePinController({
    required this.updatepinusecase,
  });

  RxBool isLoading = false.obs;

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
}