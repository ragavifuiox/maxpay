import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/get_bank_model.dart';
import 'package:maxpay/core/domain/usecase/get_bank_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_request_usecase.dart';

class GetBankController extends GetxController {
  final GetBankUseCase bankusecase;
  final WalletRequestUsecase walletRequestUsecase;
  GetBankController({
    required this.bankusecase,
    required this.walletRequestUsecase,
  });

  RxBool isLoading = false.obs;
  RxList<Data> plans = <Data>[].obs;
  Rx<Data?> selectedPlan = Rx<Data?>(null);

  @override
  void onInit() {
    super.onInit();
    getBank();
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

    print("API CALLED SUCCESSFULLY");

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