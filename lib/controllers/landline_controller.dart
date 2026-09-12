import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/usecase/landline_bill_usecase.dart';
import 'package:maxpay/core/domain/usecase/landline_pay_usecase.dart';
import 'package:maxpay/core/domain/usecase/landline_confirm_usecase.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart';
import 'package:maxpay/core/data/model/landline_confirm_model.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class LandlineController extends GetxController {
  final LandlineBillUseCase landlineBillUseCase;
  final LandlinePayUsecase landlinePayUsecase;
  final LandlineConfirmUsecase landlineConfirmUsecase;

  LandlineController({
    required this.landlineBillUseCase,
    required this.landlinePayUsecase,
    required this.landlineConfirmUsecase,
  });

  RxBool isLoading = false.obs;
  RxBool isPayLoading = false.obs;
  RxBool isConfirmLoading = false.obs;
  Rx<InstantPay?> fetchBillResponse = Rx<InstantPay?>(null);
  Rx<InstantPayBill?> payBillResponse = Rx<InstantPayBill?>(null);
  Rx<LandlineConfirmModel?> confirmResponse = Rx<LandlineConfirmModel?>(null);

  Future<bool> fetchBill({
    required String productid,
    required String consumernumber,
  }) async {
    isLoading.value = true;
    bool isSuccess = false;

    final result = await landlineBillUseCase(
      productid: productid,
      consumernumber: consumernumber,
    );

    result.fold(
      (failure) {
        isLoading.value = false;
        AppLogger.logError("Landline Bill Error: ${failure.message}");
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

  Future<bool> payBill({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  }) async {
    isPayLoading.value = true;
    bool isSuccess = false;

    final result = await landlinePayUsecase(
      productId: productId,
      consumerNumber: consumerNumber,
      amount: amount,
      reEnterAmount: reEnterAmount,
      enquiryReference: enquiryReference,
      customerMobile: customerMobile,
      whatsappNumber: whatsappNumber,
    );

    result.fold(
      (failure) {
        isPayLoading.value = false;
        AppLogger.logError("Landline Pay Error: ${failure.message}");
        CustomToast.error(failure.message);
      },
      (data) {
        isPayLoading.value = false;
        if (data.success == true) {
          payBillResponse.value = data;
          isSuccess = true;
          CustomToast.success(data.message ?? "Payment successful");
        } else {
          CustomToast.error(data.message ?? "Payment failed");
        }
      },
    );
    return isSuccess;
  }

  Future<void> confirmTransaction({required String productid}) async {
    isConfirmLoading.value = true;
    final result = await landlineConfirmUsecase(productdetid: productid);

    result.fold(
      (failure) {
        isConfirmLoading.value = false;
        AppLogger.logError("Landline Confirm Error: ${failure.message}");
        CustomToast.error(failure.message);
      },
      (data) {
        isConfirmLoading.value = false;
        if (data.success == true) {
          confirmResponse.value = data;
        } else {
          CustomToast.error(data.message ?? "Confirm failed");
        }
      },
    );
  }
}
