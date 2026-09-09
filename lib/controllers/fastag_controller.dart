import 'package:get/get.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/data/model/fastag_confirm_model.dart';
import 'package:maxpay/core/domain/usecase/fastag_confirm_usecase.dart';
import 'package:maxpay/core/domain/usecase/fastag_fetch_bill_usecase.dart';

class FastagController extends GetxController {
  final FetchFastagBillUseCase fetchFastagBillUseCase;
  final FastagConfirmUsecase confirmUsecase;

  FastagController({
    required this.fetchFastagBillUseCase,
    required this.confirmUsecase,
  });

  var isFetchBillLoading = false.obs;
  var fetchBillResponse = Rx<InstantPay?>(null);

  var isConfirmLoading = false.obs;
  var confirmResponse = Rx<FastagConfirmModel?>(null);

  Future<bool> fetchBill(String productId, String consumerNumber) async {
    isFetchBillLoading.value = true;
    final result = await fetchFastagBillUseCase(
      productId: productId,
      consumerNumber: consumerNumber,
    );

    isFetchBillLoading.value = false;

    return result.fold(
      (failure) {
        Get.snackbar('Error', 'Failed to fetch fastag bill');
        return false;
      },
      (response) {
        if (response.success == true && response.data != null) {
          fetchBillResponse.value = response;
          return true;
        } else {
          Get.snackbar(
            'Fastag Bill',
            response.message ?? 'Unknown error occurred',
          );
          return false;
        }
      },
    );
  }

  Future<bool> fetchConfirmTransaction(String productId) async {
    isConfirmLoading.value = true;
    final result = await confirmUsecase(productdetid: productId);

    isConfirmLoading.value = false;

    return result.fold(
      (failure) {
        Get.snackbar('Error', 'Failed to load confirmation details');
        return false;
      },
      (response) {
        if (response.success == true && response.data != null) {
          confirmResponse.value = response;
          return true;
        } else {
          Get.snackbar(
            'Confirm Fetch',
            response.message ?? 'Unknown error occurred',
          );
          return false;
        }
      },
    );
  }
}
