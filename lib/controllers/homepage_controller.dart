import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/compalints_model.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/popup_message_mode.dart';
import 'package:maxpay/core/data/model/transaction_suc_faii_model.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/domain/usecase/complaints_usecase.dart';
import 'package:maxpay/core/domain/usecase/news_usecase.dart';
import 'package:maxpay/core/domain/usecase/popup_message_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_suc_fail_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  final GetNewsUseCase getNewsUseCase;
  final GetWalletBalanceUseCase getWalletBalanceUseCase;
  final TransSucFailUsecase transSucFailUsecase;
  final ComplaintsUseCase complaintsUseCase;
  final GetPopupMessageUseCase getPopupMessageUseCase;

  HomePageController({
    required this.getNewsUseCase,
    required this.getWalletBalanceUseCase,
    required this.transSucFailUsecase,
    required this.complaintsUseCase,
    required this.getPopupMessageUseCase,
  });

  final news = <News>[].obs;  
  Rxn<TransactionResponse> transactionData =
      Rxn<TransactionResponse>();
  final Rx<WalletBalance?> walletBalance = Rx<WalletBalance?>(null);
   final Rx<PopupMessage?> popupMessage = Rx<PopupMessage?>(null);
    final Rx<Complaints?> complaints = Rx<Complaints?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
    fetchWalletBalance();
    fetchComplaints();
    getTransactionSummary();
  }

  Future<void> fetchNews() async {
    isLoading.value = true;

    final result = await getNewsUseCase();

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar('Error', failure.message);
      },
      (data) {
        isLoading.value = false;
        news.value = [data];
      },
    );
  }
  
Future<void> fetchpopupmessage(String currentScreen) async {
  isLoading.value = true;

  final result = await getPopupMessageUseCase();

  result.fold(
    (failure) {
      isLoading.value = false;
      Get.snackbar('Error', failure.message);
    },
    (data) async {
      isLoading.value = false;

      popupMessage.value = data;

      final popupList = data.data ?? [];

      for (var popupData in popupList) {

        // screen check
        if ((popupData.screenType ?? "").toLowerCase() !=
            currentScreen.toLowerCase()) {
          continue;
        }

        // user type check
       String currentUserType = "Retailer";

List<dynamic> userTypes = [];

if (popupData.userType != null &&
    popupData.userType!.isNotEmpty) {

  userTypes = jsonDecode(
    popupData.userType!,
  );
}

if (!userTypes.contains(currentUserType)) {
  continue;
}
        // count logic
        String noOfMsg = popupData.noOfMsg ?? "0-0";

        List<String> split = noOfMsg.split("-");

        int maxCount = int.tryParse(split.last) ?? 0;

        final prefs = await SharedPreferences.getInstance();

        String key =
            "popup_${popupData.id}_$currentScreen";

        int currentCount = prefs.getInt(key) ?? 0;

        if (currentCount >= maxCount) {
          continue;
        }

        // increment
        await prefs.setInt(key, currentCount + 1);

        // popup show
        Future.delayed(const Duration(milliseconds: 500), () {
  Get.dialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.4),

    Dialog(
  
      elevation: 0,

      child: Stack(
        clipBehavior: Clip.none,
        children: [

          /// MAIN BOX
          Container(
            width: 250,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 22,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),

              // boxShadow: [
              //   BoxShadow(
              //     // color: Colors.black.withValues(alpha: 0.15),
              //     blurRadius: 10,
              //     offset: const Offset(0, 4),
              //   ),
              // ],
            ),

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 18,
              ),

              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff6C63FF),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Text(
                popupData.message ?? "",
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ),
          ),

          /// CLOSE BUTTON
          Positioned(
  right: -5,
  top: -5,
  child: GestureDetector(
    onTap: () {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    },
    child: Container(
      height: 22,
      width: 22,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 14,
        ),
      ),
    ),
  ),
),
        ],
      ),
    ),
  );
});

        break;
      }
    },
  );
}
  Future<void> fetchWalletBalance() async {

  isLoading.value = true;

  final result = await getWalletBalanceUseCase();

  result.fold(

    (failure) {

      print("ERROR : ${failure.message}");

      isLoading.value = false;

      Get.snackbar('Error', failure.message);
    },

    (data) {

      print("FULL RESPONSE : ${data.toJson()}");

      print("BALANCE : ${data.data?.balance}");

      print("TYPE : ${data.data?.balance.runtimeType}");

      isLoading.value = false;

      walletBalance.value = data;
    },
  );
}

 Future<void> fetchComplaints() async {

  isLoading.value = true;

  print("FETCH COMPLAINTS API CALLING");

  final result = await complaintsUseCase();

  print("API RESULT : $result");

  result.fold(

    (failure) {

      print("API ERROR : ${failure.message}");

      isLoading.value = false;

      Get.snackbar(
        'Error',
        failure.message,
      );
    },

    (data) {

      print("FULL RESPONSE : ${data.toJson()}");

      print("SUCCESS : ${data.success}");

      print("MESSAGE : ${data.message}");

      print(
        "COMPLAINT COUNT : ${data.data?.complaintCount}",
      );

      print(
        "TYPE : ${data.data?.complaintCount.runtimeType}",
      );

      isLoading.value = false;

      complaints.value = data;
    },
  );
}
  Future<void> getTransactionSummary() async {
    isLoading.value = true;

    final result = await transSucFailUsecase();

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (data) {
        transactionData.value = data;
      },
    );

    isLoading.value = false;
  }
}
