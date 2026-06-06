import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:maxpay/core/data/model/compalints_model.dart' hide Data;
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/popup_message_mode.dart' hide Data;
import 'package:maxpay/core/data/model/transaction_suc_faii_model.dart' hide Data;
import 'package:maxpay/core/data/model/wallet_balance.dart' hide Data;

import 'package:maxpay/core/domain/usecase/complaints_usecase.dart';
import 'package:maxpay/core/domain/usecase/news_usecase.dart';
import 'package:maxpay/core/domain/usecase/popup_message_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_suc_fail_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_usecase.dart';

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

  Rxn<TransactionResponse> transactionData = Rxn<TransactionResponse>();
  final Rx<WalletBalance?> walletBalance = Rx<WalletBalance?>(null);
  final Rx<PopupMessage?> popupMessage = Rx<PopupMessage?>(null);
  final Rx<Complaints?> complaints = Rx<Complaints?>(null);
  final Rx<News?> news = Rx<News?>(null);

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    Future.microtask(() async {
      await fetchNews();
      await fetchWalletBalance();
      await fetchComplaints();
      await getTransactionSummary();
    });
  }

  // ---------------- NEWS ----------------
  Future<void> fetchNews() async {
    try {
      isLoading.value = true;

      final result = await getNewsUseCase();

      result.fold(
        (failure) {
          Get.snackbar('Error', failure.message);
        },
        (data) {
          news.value = data;
        },
      );
    } catch (e) {
      AppLogger.logError("fetchNews error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- POPUP ----------------
  Future<void> fetchpopupmessage(String currentScreen) async {
    try {
      isLoading.value = true;

      final result = await getPopupMessageUseCase();

      result.fold(
        (failure) {
          Get.snackbar('Error', failure.message);
        },
        (data) async {
          popupMessage.value = data;

          final popupList = data.data ?? [];

          for (var popupData in popupList) {
            if ((popupData.screenType ?? "").toLowerCase() !=
                currentScreen.toLowerCase()) {
              continue;
            }

            String currentUserType = "Retailer";

            List<dynamic> userTypes = [];
            if (popupData.userType != null &&
                popupData.userType!.isNotEmpty) {
              userTypes = jsonDecode(popupData.userType!);
            }

            if (!userTypes.contains(currentUserType)) continue;

            String noOfMsg = popupData.noOfMsg ?? "0-0";
            int maxCount = int.tryParse(noOfMsg.split("-").last) ?? 0;

            final prefs = await SharedPreferences.getInstance();
            String key = "popup_${popupData.id}_$currentScreen";

            int currentCount = prefs.getInt(key) ?? 0;

            if (currentCount >= maxCount) continue;

            await prefs.setInt(key, currentCount + 1);

            Future.delayed(const Duration(milliseconds: 500), () {
              if (Get.isDialogOpen ?? false) return;

              Get.dialog(
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.4),
                Dialog(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 250,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          popupData.message ?? "",
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Positioned(
                        right: -5,
                        top: -5,
                        child: GestureDetector(
                          onTap: () {
                            if (Get.isDialogOpen ?? false) {
                              Get.back();
                            }
                          },
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close,
                                size: 14, color: Colors.white),
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
    } catch (e) {
      AppLogger.logError("popup error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- WALLET ----------------
  Future<void> fetchWalletBalance() async {
    try {
      final result = await getWalletBalanceUseCase();

      result.fold(
        (failure) => Get.snackbar('Error', failure.message),
        (data) => walletBalance.value = data,
      );
    } catch (e) {
      AppLogger.logError("wallet error: $e");
    }
  }

  // ---------------- COMPLAINTS ----------------
  Future<void> fetchComplaints() async {
    try {
      final result = await complaintsUseCase();

      result.fold(
        (failure) => Get.snackbar('Error', failure.message),
        (data) => complaints.value = data,
      );
    } catch (e) {
      AppLogger.logError("complaints error: $e");
    }
  }

  // ---------------- TRANSACTION ----------------
  Future<void> getTransactionSummary() async {
    try {
      final result = await transSucFailUsecase();

      result.fold(
        (failure) => Get.snackbar("Error", failure.message),
        (data) => transactionData.value = data,
      );
    } catch (e) {
      AppLogger.logError("transaction error: $e");
    }
  }
}