import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/usecase/electricity_bill_usecase.dart';
import 'package:maxpay/core/domain/usecase/electricity_confirm_usecase.dart';
import 'package:maxpay/core/domain/usecase/electricity_pay_usecase.dart';
import 'package:maxpay/core/data/model/electricity_confirm_model.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart' as pay;
import 'package:maxpay/core/utils/logg_helper.dart';

class ElectricityController extends GetxController {
  final ElectricityBillUseCase electricityBillUseCase;
  final ElectricityConfirmUsecase electricityConfirmUsecase;
  final ElectricityPayUsecase electricityPayUseCase;

  ElectricityController({
    required this.electricityBillUseCase,
    required this.electricityConfirmUsecase,
    required this.electricityPayUseCase,
  });

  RxBool isLoading = false.obs;
  RxBool isConfirmLoading = false.obs;
  RxBool isPayLoading = false.obs;
  Rx<InstantPay?> fetchBillResponse = Rx<InstantPay?>(null);
  Rx<ElectricityConfirmModel?> confirmResponse = Rx<ElectricityConfirmModel?>(
    null,
  );
  Rx<pay.InstantPayBill?> payResponse = Rx<pay.InstantPayBill?>(null);

  Future<bool> fetchBill({
    required String productid,
    required String consumernumber,
  }) async {
    isLoading.value = true;
    bool isSuccess = false;

    final result = await electricityBillUseCase(
      productid: productid,
      consumernumber: consumernumber,
    );

    result.fold(
      (failure) {
        isLoading.value = false;
        AppLogger.logError("Electricity Bill Error: ${failure.message}");
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

  Future<void> confirmTransaction({
    required String productId,
    required String consumerNumber,
  }) async {
    isConfirmLoading.value = true;
    final result = await electricityConfirmUsecase(
      productId: productId,
      consumerNumber: consumerNumber,
    );

    result.fold(
      (failure) {
        isConfirmLoading.value = false;
        AppLogger.logError("Electricity Confirm Error: ${failure.message}");
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

  Future<pay.InstantPayBill?> payTransaction({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  }) async {
    print("----- Calling electricityPayUseCase -----");
    isPayLoading.value = true;
    final result = await electricityPayUseCase(
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
        print("----- Electricity Pay Result: FAILURE -----");
        print(failure.message);
        isPayLoading.value = false;
        AppLogger.logError("Electricity Pay Error: ${failure.message}");
        CustomToast.error(failure.message);
      },
      (data) {
        isPayLoading.value = false;
        payResult = data;
        if (data.success == true) {
          payResponse.value = data;
          CustomToast.success(data.message ?? "Payment successful");
        } else {
          CustomToast.error(data.message ?? "Payment failed");
        }
      },
    );

    return payResult;
  }
}
