import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/wallet_qr_history.dart';
import 'package:maxpay/core/domain/usecase/wallet_create_qr_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/view/add_wallet/widge/add_wallet_dialogue.dart';

class AddWalletController extends GetxController with WidgetsBindingObserver {
  final WalletCreateQrUsecase createQrUsecase;
  AddWalletController({required this.createQrUsecase}) {
    getWalletHistory();
  }
  RxBool isLoading = false.obs;
  final TextEditingController amountController = TextEditingController();

  Timer? _timer;
  final RxInt remainingSeconds = 300.obs;
  String? _activeTxnId;
  String _lastAmount = '0.00';

  RxBool isCheckingStatus = false.obs;
  Rx<WalletQrHistory> walletQrHistory = WalletQrHistory().obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppLogger.debugPrint("App resumed. Active Txn ID: $_activeTxnId");
      if (_activeTxnId != null && remainingSeconds.value > 0) {
        checkPaymentStatus(_activeTxnId!);
        if (_timer == null || !_timer!.isActive) {
          startTimer(_activeTxnId!);
        }
      }
    }
  }

  void startTimer(String txnId) {
    _timer?.cancel();
    _activeTxnId = txnId;
    remainingSeconds.value = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        if (remainingSeconds.value % 5 == 0) {
          checkPaymentStatus(txnId);
        }
      } else {
        stopTimer();
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        amountController.clear();
        CustomToast.error("Payment session expired");
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _activeTxnId = null;
  }

  Future<void> checkPaymentStatus(String txnId) async {
    if (isCheckingStatus.value) return;
    isCheckingStatus.value = true;

    final result = await createQrUsecase.checkQrStatus(txnId: txnId);

    result.fold(
      (failure) {
        AppLogger.debugPrint(
          "Status check: pending/failed: ${failure.message}",
        );
      },
      (status) {
        if (status == "success") {
          stopTimer();
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          final successAmount = _lastAmount;
          amountController.clear();
          showSuccessDialog(successAmount);

          if (Get.isRegistered<HomePageController>()) {
            Get.find<HomePageController>().fetchWalletBalance();
          }
          getWalletHistory();
        }
        AppLogger.debugPrint("Status check: pending/failed: $status");
      },
    );

    isCheckingStatus.value = false;
  }

  void showSuccessDialog(String amount) {
    final isDark = Get.theme.brightness == Brightness.dark;
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: isDark ? const Color(0xff1E1E2E) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 48,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Payment Successful",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "${amount.currencyIndian} has been successfully added to your wallet.",
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff004B8F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> createQr(String amount) async {
    isLoading.value = true;
    update();
    _lastAmount = amount;
    final result = await createQrUsecase.createQrAmount(amount: amount);

    result.fold(
      (failure) {
        AppLogger.debugPrint("------------CREATE QR CALLED----------");
        AppLogger.logError(failure.message);
        CustomToast.error(failure.message);
        amountController.clear();
        AppLogger.debugPrint("------------CREATE QR END----------");
      },
      (response) {
        // CustomToast.success(response.);
        AppLogger.debugPrint("------------CREATE QR CALLED----------");
        AppLogger.logError(response.toJson());

        startTimer(response.txnId ?? '');

        Get.dialog(
          AddWalletPopup(
            amount: amount,
            txtionId: response.txnId ?? '',
            url: response.upiLink ?? '',
          ),
        ).then((_) {
          stopTimer();
          amountController.clear();
        });

        AppLogger.debugPrint("------------CREATE QR END----------");
      },
    );
    isLoading.value = false;
    update();
  }

  Future<void> getWalletHistory() async {
    isLoading.value = true;
    update();
    final result = await createQrUsecase.getWalletHistory();

    result.fold(
      (failure) {
        AppLogger.debugPrint("------------GET WALLET HISTORY CALLED----------");
        AppLogger.logError(failure.message);
        CustomToast.error(failure.message);
        AppLogger.debugPrint("------------GET WALLET HISTORY END----------");
      },
      (response) {
        // CustomToast.success(response.);
        AppLogger.debugPrint("------------GET WALLET HISTORY CALLED----------");
        AppLogger.logError(response.toJson());
        walletQrHistory.value = response;
        AppLogger.debugPrint("------------GET WALLET HISTORY END----------");
      },
    );
    isLoading.value = false;
    update();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    stopTimer();
    amountController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopTimer();
    amountController.dispose();
    super.dispose();
  }
}
