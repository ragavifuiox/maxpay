import 'package:get/get.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart' as pay;
import 'package:maxpay/core/data/model/fastag_confirm_model.dart';
import 'package:maxpay/core/domain/usecase/fastag_confirm_usecase.dart';
import 'package:maxpay/core/domain/usecase/fastag_pay_usecase.dart';
import 'package:maxpay/core/domain/usecase/fastag_fetch_bill_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/constants/snackbar.dart';

class FastagController extends GetxController {
  final FetchFastagBillUseCase fetchFastagBillUseCase;
  final FastagConfirmUsecase confirmUsecase;
  final FastagPayUsecase payUsecase;

  FastagController({
    required this.fetchFastagBillUseCase,
    required this.confirmUsecase,
    required this.payUsecase,
  });

  var isFetchBillLoading = false.obs;
  var fetchBillResponse = Rx<InstantPay?>(null);

  var isConfirmLoading = false.obs;
  var confirmResponse = Rx<FastagConfirmModel?>(null);

  var isPayLoading = false.obs;

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

  Future<pay.InstantPayBill?> payTransaction({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  }) async {
    print("----- Calling fastagPayUsecase -----");
    isPayLoading.value = true;
    final result = await payUsecase(
      productId: productId,
      consumerNumber: consumerNumber,
      amount: amount,
      reEnterAmount: reEnterAmount,
      enquiryReference: enquiryReference,
      customerMobile: customerMobile,
      whatsappNumber: whatsappNumber,
    );

    pay.InstantPayBill? payResult;

    result.fold(
      (failure) {
        print("----- Fastag Pay Result: FAILURE -----");
        print(failure.message);
        isPayLoading.value = false;
        AppLogger.logError("Fastag Pay Error: ${failure.message}");
        CustomToast.error(failure.message);
      },
      (data) {
        print("----- Fastag Pay Result: SUCCESS -----");
        isPayLoading.value = false;
        payResult = data;
      },
    );

    return payResult;
  }
}
