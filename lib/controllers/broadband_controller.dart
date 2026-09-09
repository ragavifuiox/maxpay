import 'package:get/get.dart';
import 'package:maxpay/core/data/model/broadband_confirm_model.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/domain/usecase/broadband_confirm_usecase.dart';
import 'package:maxpay/core/domain/usecase/broadband_usecase.dart';

class BroadbandController extends GetxController {
  final BroadbandBillUsecase broadbandBillUsecase;

  BroadbandController(this.broadbandBillUsecase);

  var isFetchBillLoading = false.obs;
  var fetchBillResponse = Rx<InstantPay?>(null);

  Future<bool> fetchBill(String productId, String consumerNumber) async {
    isFetchBillLoading.value = true;
    final result = await broadbandBillUsecase(
      productId: productId,
      consumerNumber: consumerNumber,
    );

    isFetchBillLoading.value = false;

    return result.fold(
      (failure) {
        print("BROADBAND FETCH BILL FAILED: ${failure.message}");
        Get.snackbar('Error', 'Failed to fetch broadband bill');
        return false;
      },
      (response) {
        if (response.success == true && response.data != null) {
          print(
            "BROADBAND FETCH BILL SUCCESS: ${response.data?.bill?.customerName}",
          );
          fetchBillResponse.value = response;
          return true;
        } else {
          Get.snackbar(
            'Broadband Bill',
            response.message ?? 'Unknown error occurred',
          );
          return false;
        }
      },
    );
  }

  var isConfirmLoading = false.obs;
  var confirmResponse = Rx<BroadbandConfirmModel?>(null);

  Future<void> confirmTransaction(String productId) async {
    isConfirmLoading.value = true;
    final result = await sl<BroadbandConfirmUsecase>().call(
      productId: productId,
    );

    isConfirmLoading.value = false;

    result.fold(
      (failure) {
        print("BROADBAND CONFIRM FAILED: ${failure.message}");
        Get.snackbar('Error', 'Failed to fetch confirm details');
      },
      (response) {
        if (response.success == true && response.data != null) {
          confirmResponse.value = response;
        } else {
          Get.snackbar(
            'Confirm Details',
            response.message ?? 'Failed to load details',
          );
        }
      },
    );
  }
}
