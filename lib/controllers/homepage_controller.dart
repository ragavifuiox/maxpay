import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/faq_model.dart';
import 'package:maxpay/core/data/model/graph_model.dart' hide Data;
import 'package:maxpay/core/data/model/refund_count_model.dart';
import 'package:maxpay/core/data/model/today_credit_model.dart';
import 'package:maxpay/core/domain/usecase/faq_usecase.dart';
import 'package:maxpay/core/domain/usecase/graph_usecase.dart';
import 'package:maxpay/core/domain/usecase/refund_count_usecase.dart';
import 'package:maxpay/core/domain/usecase/today_credit_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maxpay/core/data/model/compalints_model.dart' hide Data;
import 'package:maxpay/core/data/model/news_model.dart' hide Data;
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
  final FaqUsecase faqUsecase;

  HomePageController({
    required this.getNewsUseCase,
    required this.getWalletBalanceUseCase,
    required this.transSucFailUsecase,
    required this.complaintsUseCase,
    required this.getPopupMessageUseCase,
    required this.refundCountUsecase,
    required this.todaycreditusecase,
    required this.graphUsecase,
    required this.faqUsecase,
  });

  Rxn<TransactionResponse> transactionData = Rxn<TransactionResponse>();
  final Rx<WalletBalance?> walletBalance = Rx<WalletBalance?>(null);
  final Rx<PopupMessage?> popupMessage = Rx<PopupMessage?>(null);
  final Rx<Complaints?> complaints = Rx<Complaints?>(null);
  final Rx<RefundCount?> refundcount = Rx<RefundCount?>(null);
  final Rx<TodayCredit?> todaycredit = Rx<TodayCredit?>(null);
  final Rx<News?> news = Rx<News?>(null);
  final Rx<Graph?> graphData = Rx<Graph?>(null);
  final Rx<Faq?> faq = Rx<Faq?>(null);

  RxBool isLoading = false.obs;

  /// Shared mutex so the FAQ popup and the generic popup message
  /// never appear on screen at the same time. Any code that opens
  /// one of these dialogs must set this to `true` right before
  /// calling `Get.dialog(...)` and reset it to `false` when the
  /// dialog is closed.
  static bool isPopupOpen = false;

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
      await fetchFaq();
    });
  }

  Future<void> fetchFaq() async {
    print("🚀 fetchFaq() Called");

    try {
      isLoading.value = true;

      final result = await faqUsecase();

      result.fold(
        (failure) {
          print("❌ API Failed: ${failure.message}");
          CustomToast.error(failure.message);
        },
        (data) async {
          print("✅ API Success");
          print("📦 Data Count: ${data.data?.length}");

          faq.value = data;

          // Only proceed when the backend actually returned FAQ data.
          if (data.data == null || data.data!.isEmpty) {
            print("⚠️ FAQ Data is Empty");
            return;
          }

          final faqData = data.data!.first;

          print("📅 From Date: ${faqData.liveFromDate}");
          print("📅 To Date: ${faqData.liveToDate}");

          final now = DateTime.now();
          final fromDate = faqData.liveFromDate ?? DateTime.now();
          final toDate = (faqData.liveFromDate ?? DateTime.now()).add(
            const Duration(days: 1),
          );

          print("🕒 Current Time: $now");

          if (now.isAfter(fromDate.subtract(const Duration(seconds: 1))) &&
              now.isBefore(toDate)) {
            print("🎉 Showing FAQ Popup");
            await _showFaqPopup(faqData);
          } else {
            print("🚫 Date Condition Failed");
          }
        },
      );
    } catch (e) {
      print("🔥 Exception: $e");
    } finally {
      isLoading.value = false;
      print("🏁 fetchFaq() Completed");
    }
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

          // Only proceed when the backend actually returned popup data.
          final popupList = data.data ?? [];
          if (popupList.isEmpty) {
            AppLogger.debugPrint("⚠️ No popup message data returned");
            return;
          }

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

            // Don't consume an attempt if a popup is already visible
            // (or about to be) — try again on the next fetch instead.
            if ((Get.isDialogOpen ?? false) || HomePageController.isPopupOpen) {
              AppLogger.debugPrint(
                "⚠️ Skipping popup message — another popup is already open",
              );
              break;
            }

            String noOfMsg = popupData.noOfMsg ?? "0-0";
            int maxCount = int.tryParse(noOfMsg.split("-").last) ?? 0;

            final prefs = await SharedPreferences.getInstance();
            String key = "popup_${popupData.id}_$currentScreen";

            int currentCount = prefs.getInt(key) ?? 0;

            if (currentCount >= maxCount) continue;

            await prefs.setInt(key, currentCount + 1);

            Future.delayed(const Duration(milliseconds: 500), () {
              if ((Get.isDialogOpen ?? false) ||
                  HomePageController.isPopupOpen) {
                return;
              }

              HomePageController.isPopupOpen = true;

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
                          color: Theme.of(
                            navigator?.context ?? Get.context!,
                          ).scaffoldBackgroundColor,
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
                            HomePageController.isPopupOpen = false;
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

Future<void> _showFaqPopup(Data faqData) async {
  print("🎈 _showFaqPopup() Called");
  final prefs = await SharedPreferences.getInstance();

  String today =
      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

  String key = "faq_popup_$today";

  bool alreadyShown = prefs.getBool(key) ?? false;

  print("🔑 FAQ popup key: $key | alreadyShown: $alreadyShown");

  if (alreadyShown) {
    print("🚫 FAQ popup already shown today — skipping");
    return;
  }

  // Don't open the FAQ popup on top of (or racing with) the generic
  // popup message — whichever gets here first wins for this session.
  if ((Get.isDialogOpen ?? false) || HomePageController.isPopupOpen) {
    print("⚠️ Skipping FAQ popup — another popup is already open");
    return;
  }

  await prefs.setBool(key, true);

  HomePageController.isPopupOpen = true;

  Get.dialog(
    barrierDismissible: false,
    Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Banner Image
                if ((faqData.image ?? "").isNotEmpty)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      faqData.image!,
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter Comments",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Interest",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  HomePageController.isPopupOpen = false;
                                  Get.back();
                                },
                                child: const Text("Replay 1"),
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  HomePageController.isPopupOpen = false;
                                  Get.back();
                                },
                                child: const Text("Replay 2"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Close Button
          Positioned(
            top: -12,
            right: -12,
            child: InkWell(
              onTap: () {
                HomePageController.isPopupOpen = false;
                Get.back();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.close, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
