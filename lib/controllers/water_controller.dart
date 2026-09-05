import 'package:get/get.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/usecase/water_bill_usecase.dart';

class WaterController extends GetxController {
  final WaterBillUsecase waterBillUsecase;

  WaterController(this.waterBillUsecase);

  var isFetchBillLoading = false.obs;
  var fetchBillResponse = Rx<InstantPay?>(null);

  Future<bool> fetchBill(String productId, String customerId) async {
    isFetchBillLoading.value = true;
    final result = await waterBillUsecase(
      productId: productId,
      customerId: customerId,
    );

    isFetchBillLoading.value = false;

    return result.fold(
      (failure) {
        Get.snackbar('Error', 'Failed to fetch water bill');
        return false;
      },
      (response) {
        if (response.success == true && response.data != null) {
          fetchBillResponse.value = response;
          return true;
        } else {
          Get.snackbar(
            'Water Bill',
            response.message ?? 'Unknown error occurred',
          );
          return false;
        }
      },
    );
  }
}
