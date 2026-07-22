import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/due_amount_model.dart';
import 'package:maxpay/core/data/model/get_bank_model.dart';
import 'package:maxpay/core/domain/usecase/due_amount_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_bank_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_request_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class GetBankController extends GetxController {
  final GetBankUseCase bankusecase;
  final WalletRequestUsecase walletRequestUsecase;
  final DueAmountUsecase dueAmountUsecase;

  GetBankController({
    required this.bankusecase,
    required this.walletRequestUsecase,
    required this.dueAmountUsecase,
  });

  RxBool isLoading = false.obs;
  RxList<Data> plans = <Data>[].obs;
  Rx<Data?> selectedPlan = Rx<Data?>(null);
  final Rx<DueAmount?> dueamount = Rx<DueAmount?>(null);

  @override
  void onInit() {
    super.onInit();
    getBank();
     fetchDueAmount();
  }

  Future<void> getBank() async {
    try {
      isLoading.value = true;

      final result = await bankusecase();

      result.fold(
        (failure) {
          Get.snackbar(
            "Error",
            failure.message,
          );
        },
        (response) {
          plans.assignAll(
            response.data ?? [],
          );

          if (plans.isNotEmpty) {
            selectedPlan.value =
                plans.first;
          }
        },
        
      );

    } finally {
      isLoading.value = false;
    }
  }


Future<void> createWalletRequest({
  required String amount,
  required String paymenttype,
  required String utrno,
  required String bankid,
  required String description,
  required String receipt,
}) async {
  try {
    isLoading.value = true;

    final result = await walletRequestUsecase(
      amount: amount,
      paymenttype: paymenttype,
      utrno: utrno,
      bankid: bankid,
      description: description,
      receipt: receipt,
    );

    AppLogger.debugPrint("API CALLED SUCCESSFULLY");

    result.fold(
      (failure) {

        // ❌ ERROR TOAST
        CustomToast.error(
          failure.message.toString(),
        );

        debugPrint("ERROR: ${failure.message}");
      },
      (response) {

        // ✅ SUCCESS TOAST
        CustomToast.success(
          response.message ?? "Wallet Request Success",
        );

        debugPrint("SUCCESS RESPONSE: ${response.toJson()}");
      },
    );
  } catch (e) {

    // 🔥 EXCEPTION TOAST
    CustomToast.error(e.toString());

    debugPrint("EXCEPTION: $e");
  } finally {
    isLoading.value = false;
  }
}

 Future<void> fetchDueAmount() async {
  try {
    isLoading.value = true;

    final result = await dueAmountUsecase();

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (response) {
        dueamount.value = response;
      },
    );
  } catch (e) {
    AppLogger.logError("Due Amount Error: $e");
  } finally {
    isLoading.value = false;
  }
}
void clearForm({
  required TextEditingController amountController,
  required TextEditingController utrController,
  required TextEditingController descriptionController,
  required TextEditingController receiptController,
  required RxString paymentType,
  required Rx<File?> selectedImage,
}) {
  amountController.clear();

  utrController.clear();

  descriptionController.clear();

  receiptController.clear();

  paymentType.value = '';

  selectedPlan.value = null;

  selectedImage.value = null;
}
}