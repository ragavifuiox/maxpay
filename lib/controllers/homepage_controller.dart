import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/graph_model.dart';
import 'package:maxpay/core/data/model/refund_count_model.dart';
import 'package:maxpay/core/data/model/today_credit_model.dart';
import 'package:maxpay/core/domain/usecase/graph_usecase.dart';
import 'package:maxpay/core/domain/usecase/refund_count_usecase.dart';
import 'package:maxpay/core/domain/usecase/today_credit_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maxpay/core/data/model/compalints_model.dart' hide Data;
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/popup_message_mode.dart' hide Data;
import 'package:maxpay/core/data/model/transaction_suc_faii_model.dart'
    hide Data;
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
  final RefundCountUsecase refundCountUsecase;
  final TodayCreditUsecase todaycreditusecase;
  final GraphUsecase graphUsecase;

  HomePageController({
    required this.getNewsUseCase,
    required this.getWalletBalanceUseCase,
    required this.transSucFailUsecase,
    required this.complaintsUseCase,
    required this.getPopupMessageUseCase,
    required this.refundCountUsecase,
    required this.todaycreditusecase,
    required this.graphUsecase,
  });

  Rxn<TransactionResponse> transactionData = Rxn<TransactionResponse>();
  final Rx<WalletBalance?> walletBalance = Rx<WalletBalance?>(null);
  final Rx<PopupMessage?> popupMessage = Rx<PopupMessage?>(null);
  final Rx<Complaints?> complaints = Rx<Complaints?>(null);
  final Rx<RefundCount?> refundcount = Rx<RefundCount?>(null);
  final Rx<TodayCredit?> todaycredit = Rx<TodayCredit?>(null);
  final Rx<News?> news = Rx<News?>(null);
  final Rx<Graph?> graphData = Rx<Graph?>(null);

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    Future.microtask(() async {
      await fetchNews();
      await fetchWalletBalance();
      await fetchComplaints();
      await getTransactionSummary();
      await fetchRefundCount();
      await fetchtodaycredit();
      await fetchGraph();

      // await fetchpopupmessage();
    });
  }

  // ---------------- NEWS ----------------
  Future<void> fetchNews() async {
    try {
      AppLogger.debugPrint("🚀 [API CALL START] fetchNews");
      isLoading.value = true;

      final result = await getNewsUseCase();

      result.fold(
        (failure) {
         CustomToast.error(failure.message);
        },
        (data) {
          AppLogger.debugPrint("✅ [API CALL SUCCESS] fetchNews");
          news.value = data;
        },
      );
    } catch (e) {
      AppLogger.logError("🔥 [API CALL EXCEPTION] fetchNews error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGraph() async {
    try {
      AppLogger.debugPrint("🚀 [API CALL START] fetchGraph");
      isLoading.value = true;

      final result = await graphUsecase();

    result.fold(
      (failure) {
       CustomToast.error(failure.message);
      },
      (data) {
        graphData.value = data;
      },
    );
  } catch (e) {
    AppLogger.logError("fetchGraph error: $e");
  } finally {
    isLoading.value = false;
  }
}
  // ---------------- POPUP ----------------
  Future<void> fetchpopupmessage(String currentScreen) async {
    try {
      AppLogger.debugPrint(
        "🚀 [API CALL START] fetchpopupmessage for $currentScreen",
      );
      isLoading.value = true;

      final result = await getPopupMessageUseCase();

      result.fold(
        (failure) {
          AppLogger.logError(
            "❌ [API CALL FAILED] fetchpopupmessage: ${failure.message}",
          );
          Get.snackbar('Error', failure.message);
        },
        (data) async {
          AppLogger.debugPrint("✅ [API CALL SUCCESS] fetchpopupmessage");
          popupMessage.value = data;

          final popupList = data.data ?? [];

          for (var popupData in popupList) {
            if ((popupData.screenType ?? "").toLowerCase() !=
                currentScreen.toLowerCase()) {
              continue;
            }

            String currentUserType = "Retailer";

            List<dynamic> userTypes = [];
            if (popupData.userType != null && popupData.userType!.isNotEmpty) {
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
                barrierColor: Colors.black.withValues(alpha: 0.4),
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
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
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
    } catch (e) {
      AppLogger.logError("🔥 [API CALL EXCEPTION] popup error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- WALLET ----------------
  Future<void> fetchWalletBalance() async {
    try {
      AppLogger.debugPrint("🚀 [API CALL START] fetchWalletBalance");
      final result = await getWalletBalanceUseCase();

      result.fold(
        (failure) {
          AppLogger.logError(
            "❌ [API CALL FAILED] fetchWalletBalance: ${failure.message}",
          );
          Get.snackbar('Error', failure.message);
        },
        (data) {
          AppLogger.debugPrint("✅ [API CALL SUCCESS] fetchWalletBalance");
          walletBalance.value = data;
        },
      );
    } catch (e) {
      AppLogger.logError("🔥 [API CALL EXCEPTION] wallet error: $e");
    }
  }

  // ---------------- COMPLAINTS ----------------
  Future<void> fetchComplaints() async {
    try {
      AppLogger.debugPrint("🚀 [API CALL START] fetchComplaints");
      final result = await complaintsUseCase();

      result.fold(
        (failure) {
          AppLogger.logError(
            "❌ [API CALL FAILED] fetchComplaints: ${failure.message}",
          );
          Get.snackbar('Error', failure.message);
        },
        (data) {
          AppLogger.debugPrint("✅ [API CALL SUCCESS] fetchComplaints");
          complaints.value = data;
        },
      );
    } catch (e) {
      AppLogger.logError("🔥 [API CALL EXCEPTION] complaints error: $e");
    }
  }

  Future<void> fetchtodaycredit() async {
    try {
      AppLogger.debugPrint("🚀 [API CALL START] fetchtodaycredit");
      final result = await todaycreditusecase();

      result.fold(
        (failure) {
          AppLogger.logError(
            "❌ [API CALL FAILED] fetchtodaycredit: ${failure.message}",
          );
          Get.snackbar('Error', failure.message);
        },
        (data) {
          AppLogger.debugPrint("✅ [API CALL SUCCESS] fetchtodaycredit");
          todaycredit.value = data;
        },
      );
    } catch (e) {
      AppLogger.logError("🔥 [API CALL EXCEPTION] todaycredit error: $e");
    }
  }

  Future<void> fetchRefundCount() async {
    try {
      AppLogger.debugPrint("🚀 [API CALL START] fetchRefundCount");
      final result = await refundCountUsecase();

      result.fold(
        (failure) {
          AppLogger.logError(
            "❌ [API CALL FAILED] fetchRefundCount: ${failure.message}",
          );
          Get.snackbar('Error', failure.message);
        },
        (data) {
          AppLogger.debugPrint("✅ [API CALL SUCCESS] fetchRefundCount");
          refundcount.value = data;
        },
      );
    } catch (e) {
      AppLogger.logError("🔥 [API CALL EXCEPTION] refund error: $e");
    }
  }

  // ---------------- TRANSACTION ----------------
  Future<void> getTransactionSummary() async {
    try {
      AppLogger.debugPrint("🚀 [API CALL START] getTransactionSummary");
      final result = await transSucFailUsecase();

      result.fold(
        (failure) {
          AppLogger.logError(
            "❌ [API CALL FAILED] getTransactionSummary: ${failure.message}",
          );
          Get.snackbar("Error", failure.message);
        },
        (data) {
          AppLogger.debugPrint("✅ [API CALL SUCCESS] getTransactionSummary");
          transactionData.value = data;
        },
      );
    } catch (e) {
      AppLogger.logError("🔥 [API CALL EXCEPTION] transaction error: $e");
    }
  }
}
