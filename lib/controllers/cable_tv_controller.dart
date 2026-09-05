import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/data/model/cable_tv_confirm_model.dart';
import 'package:maxpay/core/domain/usecase/cable_tv_bill_usecase.dart';
import 'package:maxpay/core/domain/usecase/cable_tv_confirm_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class CableTvController extends GetxController {
  final CableTvBillUsecase cableTvBillUsecase;
  final CableTvConfirmUsecase cableTvConfirmUsecase;

  CableTvController({
    required this.cableTvBillUsecase,
    required this.cableTvConfirmUsecase,
  });

  RxBool isLoading = false.obs;
  Rx<InstantPay?> fetchBillResponse = Rx<InstantPay?>(null);

  Future<bool> fetchBill({
    required String productid,
    required String consumernumber,
  }) async {
    isLoading.value = true;
    bool isSuccess = false;

    final result = await cableTvBillUsecase(productid, consumernumber);

    result.fold(
      (failure) {
        isLoading.value = false;
        AppLogger.logError("Cable TV Error: ${failure.message}");
        CustomToast.error(failure.message);
      },
      (data) {
        isLoading.value = false;
        if (data.success == true) {
          fetchBillResponse.value = data;
          isSuccess = true;
          CustomToast.success(data.message ?? "Bill fetched successfully");
        } else {
          CustomToast.error(data.message ?? "Failed to fetch bill");
        }
      },
    );
    return isSuccess;
  }

  RxBool isConfirmLoading = false.obs;
  Rx<CableTvConfirmModel?> confirmResponse = Rx<CableTvConfirmModel?>(null);

  Future<bool> confirmTransaction(String productdetid) async {
    isConfirmLoading.value = true;
    bool isSuccess = false;

    final result = await cableTvConfirmUsecase.getCableTvConfirm(
      productdetid: productdetid,
    );

    result.fold(
      (failure) {
        isConfirmLoading.value = false;
        AppLogger.logError("Cable TV Confirm Error: ${failure.message}");
        CustomToast.error(failure.message);
      },
      (data) {
        isConfirmLoading.value = false;
        if (data.success == true) {
          confirmResponse.value = data;
          isSuccess = true;
        } else {
          CustomToast.error(data.message ?? "Confirm transaction failed");
        }
      },
    );
    return isSuccess;
  }
}
