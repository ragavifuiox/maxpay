import 'package:get/get.dart';
import 'package:maxpay/core/data/model/broadband_confirm_model.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/domain/usecase/broadband_confirm_usecase.dart';
import 'package:maxpay/core/domain/usecase/broadband_usecase.dart';
import 'package:maxpay/core/domain/usecase/broadband_pay_usecase.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart';
import 'package:maxpay/core/constants/routes_path.dart';

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

  var isPayLoading = false.obs;

  Future<InstantPayBill?> payTransaction({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  }) async {
    isPayLoading.value = true;
    final result = await sl<BroadbandPayUsecase>().call(
      productId: productId,
      consumerNumber: consumerNumber,
      amount: amount,
      reEnterAmount: reEnterAmount,
      enquiryReference: enquiryReference,
      customerMobile: customerMobile,
      whatsappNumber: whatsappNumber,
    );

    isPayLoading.value = false;
    InstantPayBill? payResult;

    result.fold(
      (failure) {
        print("BROADBAND PAY FAILED: ${failure.message}");
        Get.snackbar('Error', 'Payment failed: ${failure.message}');
      },
      (data) {
        payResult = data;
        if (data.success == true) {
          Get.snackbar('Success', data.message ?? "Payment successful");
        } else {
          if (data.message?.toLowerCase().contains('insufficient') ?? false) {
            Get.toNamed(AppRoutes.walletrequest);
          } else {
            Get.snackbar('Payment Failed', data.message ?? 'Unknown error');
          }
        }
      },
    );
    return payResult;
  }
}
