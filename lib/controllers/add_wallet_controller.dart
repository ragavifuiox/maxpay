// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:maxpay/controllers/homepage_controller.dart';
// import 'package:maxpay/core/constants/snackbar.dart';
// import 'package:maxpay/core/data/model/wallet_qr_history.dart';
// import 'package:maxpay/core/domain/usecase/wallet_create_qr_usecase.dart';
// import 'package:maxpay/core/utils/logg_helper.dart';
// import 'package:maxpay/core/extensions/currency.dart';
// import 'package:maxpay/view/add_wallet/widge/add_wallet_dialogue.dart';

// class AddWalletController extends GetxController with WidgetsBindingObserver {
//   final WalletCreateQrUsecase createQrUsecase;
//   AddWalletController({required this.createQrUsecase}) {
//     getWalletHistory();
//   }
//   RxBool isLoading = false.obs;
//   final TextEditingController amountController = TextEditingController();
//   static const MethodChannel _channel = MethodChannel(
//     "com.paylink.retailor/upi_choose",
//   );
//   Timer? _timer;
//   final RxInt remainingSeconds = 300.obs;
//   String? _activeTxnId;
//   String _lastAmount = '0.00';

//   RxBool isCheckingStatus = false.obs;
//   Rx<WalletQrHistory> walletQrHistory = WalletQrHistory().obs;
//   RxList<Map<String, dynamic>> upiApps = <Map<String, dynamic>>[].obs;
//   RxBool isLoadingUpiApps = false.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       AppLogger.debugPrint("App resumed. Active Txn ID: $_activeTxnId");
//       getWalletHistory();

//       if (_activeTxnId != null && remainingSeconds.value > 0) {
//         checkPaymentStatus(_activeTxnId!);
//         if (_timer == null || !_timer!.isActive) {
//           startTimer(_activeTxnId!);
//         }
//       }
//     }
//   }

//   void startTimer(String txnId) {
//     _timer?.cancel();
//     _activeTxnId = txnId;
//     remainingSeconds.value = 300;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (remainingSeconds.value > 0) {
//         remainingSeconds.value--;
//         if (remainingSeconds.value % 5 == 0) {
//           checkPaymentStatus(txnId);
//         }
//       } else {
//         stopTimer();
//         if (Get.isDialogOpen ?? false) {
//           Get.back();
//         }
//         amountController.clear();
//         CustomToast.error("Payment session expired");
//       }
//     });
//   }

//   void stopTimer() {
//     _timer?.cancel();
//     _timer = null;
//     _activeTxnId = null;
//   }
//   // Future<void> loadInstalledUpiApps() async {
//   //   if (upiApps.isNotEmpty) return;

//   //   isLoadingUpiApps.value = true;
//   //   upiApps.value = await getInstalledUpiApps();
//   //   isLoadingUpiApps.value = false;
//   // }
//   Future<void> checkPaymentStatus(String txnId) async {
//     if (isCheckingStatus.value) return;
//     isCheckingStatus.value = true;

//     final result = await createQrUsecase.checkQrStatus(txnId: txnId);

//     result.fold(
//       (failure) {
//         AppLogger.debugPrint(
//           "Status check: pending/failed: ${failure.message}",
//         );
//       },
//       (status) {
//         if (status == "success") {
//           stopTimer();
//           if (Get.isDialogOpen ?? false) {
//             Get.back();
//           }
//           final successAmount = _lastAmount;
//           amountController.clear();
//           showSuccessDialog(successAmount);

//           if (Get.isRegistered<HomePageController>()) {
//             Get.find<HomePageController>().fetchWalletBalance();
//           }
//           getWalletHistory();
//         }
//         AppLogger.debugPrint("Status check: pending/failed: $status");
//       },
//     );

//     isCheckingStatus.value = false;
//   }

//   void showSuccessDialog(String amount) {
//     final isDark = Get.theme.brightness == Brightness.dark;
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         backgroundColor: isDark ? const Color(0xff1E1E2E) : Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 72,
//                 height: 72,
//                 decoration: BoxDecoration(
//                   color: Colors.green.withValues(alpha: 0.15),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Center(
//                   child: Icon(
//                     Icons.check_circle_rounded,
//                     size: 48,
//                     color: Colors.green,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Payment Successful",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Poppins',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 "${amount.currencyIndian} has been successfully added to your wallet.",
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: isDark ? Colors.grey[400] : Colors.grey[600],
//                   fontFamily: 'Poppins',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff004B8F),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 0,
//                   ),
//                   onPressed: () => Get.back(),
//                   child: const Text(
//                     "Done",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }

//   Future<void> createQr(String amount) async {
//     isLoading.value = true;
//     update();
//     _lastAmount = amount;
//     final result = await createQrUsecase.createQrAmount(amount: amount);

//     result.fold(
//       (failure) {
//         AppLogger.debugPrint("------------CREATE QR CALLED----------");
//         AppLogger.logError(failure.message);
//         CustomToast.error(failure.message);
//         amountController.clear();
//         AppLogger.debugPrint("------------CREATE QR END----------");
//       },
//       (response) {
//         AppLogger.debugPrint("------------CREATE QR CALLED----------");
//         AppLogger.logError(response.toJson());

//         startTimer(response.txnId ?? '');
//         loadInstalledUpiApps(); // <-- ADDED: fetch UPI apps before showing dialog

//         Get.dialog(
//           AddWalletPopup(
//             amount: amount,
//             txtionId: response.txnId ?? '',
//             url: convertToStandardUpiUrl(response.gpayLink ?? ''),
//             phonepeLink: response.phonepeLink ?? '',
//           ),
//         ).then((_) async {
//           stopTimer();
//           amountController.clear();

//           // Give backend time to update
//           await Future.delayed(const Duration(seconds: 1));

//           await getWalletHistory();
//         });
//         AppLogger.debugPrint("------------CREATE QR END----------");
//       },
//     );
//     isLoading.value = false;
//     update();
//   }

//   Future<void> loadInstalledUpiApps() async {
//     isLoadingUpiApps.value = true;
//     upiApps.value = await getInstalledUpiApps();
//     isLoadingUpiApps.value = false;
//     AppLogger.debugPrint("UPI apps found: ${upiApps.length}");
//   }

//   Future<List<Map<String, dynamic>>> getInstalledUpiApps() async {
//     try {
//       final List<dynamic> result = await _channel.invokeMethod(
//         "getInstalledUpiApps",
//       );
//       return result.map((e) => Map<String, dynamic>.from(e)).toList();
//     } on PlatformException catch (e) {
//       AppLogger.debugPrint(
//         "getInstalledUpiApps PlatformException: ${e.message}",
//       );
//       return [];
//     } catch (e) {
//       AppLogger.debugPrint("getInstalledUpiApps error: $e");
//       return [];
//     }
//   }
//   // Future<void> createQr(String amount) async {
//   //   isLoading.value = true;
//   //   update();
//   //   _lastAmount = amount;
//   //   final result = await createQrUsecase.createQrAmount(amount: amount);

//   //   result.fold(
//   //     (failure) {
//   //       AppLogger.debugPrint("------------CREATE QR CALLED----------");
//   //       AppLogger.logError(failure.message);
//   //       CustomToast.error(failure.message);
//   //       amountController.clear();
//   //       AppLogger.debugPrint("------------CREATE QR END----------");
//   //     },
//   //     (response) {
//   //       // CustomToast.success(response.);
//   //       AppLogger.debugPrint("------------CREATE QR CALLED----------");
//   //       AppLogger.logError(response.toJson());

//   //       startTimer(response.txnId ?? '');

//   //       Get.dialog(
//   //         AddWalletPopup(
//   //           amount: amount,
//   //           txtionId: response.txnId ?? '',
//   //           url: response.upiLink ?? '',
//   //         ),
//   //       ).then((_) {
//   //         stopTimer();
//   //         amountController.clear();
//   //       });

//   //       AppLogger.debugPrint("------------CREATE QR END----------");
//   //     },
//   //   );
//   //   isLoading.value = false;
//   //   update();
//   // }

//   Future<void> getWalletHistory() async {
//     isLoading.value = true;
//     update();
//     final result = await createQrUsecase.getWalletHistory();

//     result.fold(
//       (failure) {
//         AppLogger.debugPrint("------------GET WALLET HISTORY CALLED----------");
//         AppLogger.logError(failure.message);
//         CustomToast.error(failure.message);
//         AppLogger.debugPrint("------------GET WALLET HISTORY END----------");
//       },
//       (response) {
//         // CustomToast.success(response.);
//         AppLogger.debugPrint("------------GET WALLET HISTORY CALLED----------");
//         AppLogger.logError(response.toJson());
//         walletQrHistory.value = response;
//         AppLogger.debugPrint("------------GET WALLET HISTORY END----------");
//       },
//     );
//     isLoading.value = false;
//     update();
//   }

//   Future<void> openSpecificUpiApp({
//     required String packageName,
//     required String url,
//   }) async {
//     try {
//       debugPrint("========== OPEN UPI ==========");
//       debugPrint("Package: $packageName");
//       debugPrint("UPI URL: $url");

//       final result = await _channel.invokeMethod("openSpecificUpiApp", {
//         "packageName": packageName,
//         "url": url, // IMPORTANT: Don't encode here
//       });

//       debugPrint("UPI launch result: $result");
//       debugPrint("========== OPEN UPI END ==========");
//     } on PlatformException catch (e) {
//       debugPrint("UPI PlatformException: ${e.code}");
//       debugPrint("UPI Error: ${e.message}");

//       CustomToast.error(e.message ?? "Unable to open UPI app");
//     } catch (e) {
//       debugPrint("UPI Error: $e");

//       CustomToast.error("Unable to open UPI app");
//     }
//   }

//   // Future<List<Map<String, dynamic>>> getInstalledUpiApps() async {

//   //   try {

//   //     final result =
//   //         await _channel.invokeMethod("getInstalledUpiApps");

//   //     print(" 😊UPI APPS ===== $result");

//   //     return (result as List)
//   //         .map((e)=>Map<String,dynamic>.from(e))
//   //         .toList();

//   //   } catch(e){

//   //     print("UPI ERROR ===== $e");

//   //     return [];

//   //   }
//   // }
//   @override
//   void onClose() {
//     WidgetsBinding.instance.removeObserver(this);
//     stopTimer();
//     amountController.dispose();
//     super.onClose();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     stopTimer();
//     amountController.dispose();
//     super.dispose();
//   }
// }

// String convertToStandardUpiUrl(String customUrl) {
//   try {
//     final uri = Uri.parse(customUrl);

//     // If the URL has a query string, append it to the standard upi://pay format
//     if (uri.hasQuery) {
//       return 'upi://pay?${uri.query}';
//     }

//     return customUrl; // Fallback
//   } catch (e) {
//     debugPrint("Error converting UPI URL: $e");
//     return customUrl;
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';

import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/wallet_create_qr_model.dart';
import 'package:maxpay/core/data/model/wallet_qr_history.dart';
import 'package:maxpay/core/domain/usecase/wallet_create_qr_usecase.dart';

import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/view/add_wallet/widge/add_wallet_dialogue.dart';
import 'package:url_launcher/url_launcher.dart';

class AddWalletController extends GetxController with WidgetsBindingObserver {
  final WalletCreateQrUsecase createQrUsecase;

  AddWalletController({required this.createQrUsecase});

  // --------------------------------------------------------------------------
  // Controllers / Variables
  // --------------------------------------------------------------------------

  final TextEditingController amountController = TextEditingController();

  RxBool isLoading = false.obs;

  RxBool isCheckingStatus = false.obs;

  Rx<WalletQrHistory> walletQrHistory = WalletQrHistory().obs;

  RxList<Map<String, dynamic>> upiApps = <Map<String, dynamic>>[].obs;

  RxBool isLoadingUpiApps = false.obs;

  Timer? _timer;

  final RxInt remainingSeconds = 300.obs;

  String? _activeTxnId;

  String _lastAmount = '0.00';

  static const MethodChannel _channel = MethodChannel(
    "com.paylink.retailor/upi_choose",
  );

  final WeiplCheckoutFlutter wlCheckout = WeiplCheckoutFlutter();

  // --------------------------------------------------------------------------
  // INIT
  // --------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);

    wlCheckout.on(
      WeiplCheckoutFlutter.wlResponse,
      _worldlineResponseCallback,
      _worldlineErrorCallback,
    );

    getWalletHistory();
  }

  Future<void> _worldlineResponseCallback(
    Map<dynamic, dynamic> response,
  ) async {
    AppLogger.logError(response);

    final msg = response['msg'];
    final errorMsg = response['errorMsg'];

    if (msg == null || !msg.toString().contains('SUCCESS')) {
      CustomToast.error(errorMsg?.toString() ?? "Payment was not successful.");
      return;
    }

    try {
      isLoading.value = true;

      final txnId = qrResponse?.value?.worldline?.txnId ?? '';
      final merchantCode = qrResponse?.value?.worldline?.data?.merchantId ?? '';

      final formData = dio.FormData.fromMap({
        'transaction_id': txnId,
        'msg': msg.toString(),
        'merchant_code': merchantCode,
      });

      final apiService = Get.find<ApiService>();
      final verifyResponse = await apiService.post(
        ApiRoutes.verifyWorldlinePayment,
        data: formData,
      );

      AppLogger.debugPrint("Verify Response: $verifyResponse");

      if (verifyResponse['status'] == true ||
          verifyResponse['status'] == 1 ||
          verifyResponse['status'] == "true") {
        CustomToast.success(
          verifyResponse['message']?.toString() ?? "Payment successful",
        );
      } else {
        CustomToast.error(
          verifyResponse['message']?.toString() ??
              "Payment verification failed",
        );
      }
    } catch (e) {
      AppLogger.logError(e);
      CustomToast.error("Payment verification failed");
    } finally {
      isLoading.value = false;
      getWalletHistory();
    }
  }

  void _worldlineErrorCallback(Map<dynamic, dynamic> response) {
    AppLogger.logError(response);
    final errorMsg = response['errorMsg'];
    CustomToast.error(errorMsg?.toString() ?? "Payment failed or cancelled");
  }

  Future<void> openGPay(String paymentUrl) async {
    try {
      final value = paymentUrl.trim();

      debugPrint("========== OPEN GPAY ==========");
      debugPrint("URL = $value");

      final uri = Uri.tryParse(value);

      if (uri == null) {
        CustomToast.error("Invalid GPay URL");
        return;
      }

      debugPrint("SCHEME = ${uri.scheme}");
      debugPrint("HOST = ${uri.host}");
      debugPrint("QUERY = ${uri.query}");

      final canOpen = await canLaunchUrl(uri);

      debugPrint("CAN OPEN = $canOpen");

      if (!canOpen) {
        CustomToast.error("Google Pay cannot open this payment link");
        return;
      }

      final result = await launchUrl(uri, mode: LaunchMode.externalApplication);

      debugPrint("LAUNCH RESULT = $result");
      debugPrint("========== END GPAY ==========");
    } catch (e) {
      debugPrint("GPAY ERROR = $e");

      CustomToast.error("Unable to open Google Pay");
    }
  }
  // --------------------------------------------------------------------------
  // APP LIFECYCLE
  // --------------------------------------------------------------------------

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppLogger.debugPrint("App resumed. Active Txn ID: $_activeTxnId");

      getWalletHistory();

      if (_activeTxnId != null && remainingSeconds.value > 0) {
        checkPaymentStatus(_activeTxnId!);

        if (_timer == null || !_timer!.isActive) {
          startTimer(_activeTxnId!);
        }
      }
    }
  }

  // --------------------------------------------------------------------------
  // TIMER
  // --------------------------------------------------------------------------

  void startTimer(String txnId) {
    if (txnId.isEmpty) {
      return;
    }

    _timer?.cancel();

    _activeTxnId = txnId;

    remainingSeconds.value = 300;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;

        // Check payment every 2 seconds
        if (remainingSeconds.value % 2 == 0) {
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

  // --------------------------------------------------------------------------
  // CHECK PAYMENT STATUS
  // --------------------------------------------------------------------------

  Future<void> checkPaymentStatus(String txnId) async {
    if (txnId.isEmpty) {
      return;
    }

    if (isCheckingStatus.value) {
      return;
    }

    isCheckingStatus.value = true;

    try {
      final result = await createQrUsecase.checkQrStatus(txnId: txnId);

      result.fold(
        (failure) {
          AppLogger.debugPrint(
            "Payment status check failed: ${failure.message}",
          );
        },
        (status) {
          AppLogger.debugPrint("Payment status: $status");

          if (status.toString().toLowerCase() == "success") {
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
        },
      );
    } catch (e) {
      AppLogger.debugPrint("Payment status error: $e");
    } finally {
      isCheckingStatus.value = false;
    }
  }

  // --------------------------------------------------------------------------
  // CHECK INDIVIDUAL PAYMENT STATUS
  // --------------------------------------------------------------------------

  Future<void> checkIndividualPaymentStatus(String txnId, String amount) async {
    if (txnId.isEmpty) {
      return;
    }

    final isDark = Get.theme.brightness == Brightness.dark;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: .center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                "Checking payment status...",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    int secondsElapsed = 0;
    bool isSuccess = false;

    while (secondsElapsed < 60) {
      // If the user closed the loading dialog via the back button, stop polling.
      if (!(Get.isDialogOpen ?? false)) {
        return;
      }

      await Future.delayed(const Duration(seconds: 3));
      secondsElapsed += 3;

      try {
        final result = await createQrUsecase.checkQrStatus(txnId: txnId);
        result.fold((failure) {}, (status) {
          if (status.toString().toLowerCase() == "success") {
            isSuccess = true;
          }
        });

        if (isSuccess) break;
      } catch (e) {
        
      }
    }

  
    if (!(Get.isDialogOpen ?? false)) {
      return;
    }

    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (isSuccess) {
      showSuccessDialog(amount);
      if (Get.isRegistered<HomePageController>()) {
        Get.find<HomePageController>().fetchWalletBalance();
      }
      getWalletHistory();
    } else {
      showPendingDialog(amount);
    }
  }

  // --------------------------------------------------------------------------
  // SUCCESS DIALOG
  // --------------------------------------------------------------------------

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
                "₹$amount has been successfully "
                "added to your wallet.",
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
                  onPressed: () {
                    Get.back();
                  },
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

  // --------------------------------------------------------------------------
  // PENDING DIALOG
  // --------------------------------------------------------------------------

  void showPendingDialog(String amount) {
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
                  color: Colors.orange.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.access_time_filled_rounded,
                    size: 48,
                    color: Colors.orange,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Payment Pending",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              Text(
                "If your status is pending and payment is done, kindly contact the support team with transaction proof.",
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
                  onPressed: () {
                    Get.back();
                  },
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

  // --------------------------------------------------------------------------
  // CREATE QR
  // --------------------------------------------------------------------------
  Rx<CreateQrResponse>? qrResponse;
  Future<void> createQr(String amount) async {
    if (amount.trim().isEmpty) {
      CustomToast.error("Please Enter Amount");
      return;
    }

    isLoading.value = true;

    update();

    _lastAmount = amount.trim();

    try {
      final result = await createQrUsecase.createQrAmount(
        amount: amount.trim(),
      );

      result.fold(
        (failure) {
          AppLogger.debugPrint("------------ CREATE QR FAILED ------------");

          AppLogger.logError(failure.message);

          CustomToast.error(failure.message);

          amountController.clear();
        },
        (response) {
          AppLogger.debugPrint("------------ CREATE QR SUCCESS ------------");

          AppLogger.logError(response.toJson());
          qrResponse?.value = response;
          final ekqrData = qrResponse?.value.ekqr;
          final wordlinkData = qrResponse?.value.worldline;

          // if (txnId.isEmpty) {
          //   CustomToast.error("Transaction ID not received");
          //   return;
          // }

          // --------------------------------------------------------------
          // IMPORTANT:
          // Convert backend link to standard UPI URI
          // --------------------------------------------------------------

          final qrUpiUrl = convertToStandardUpiUrl(
            response.ekqr?.upiLink ?? '',
          );

          AppLogger.debugPrint("==========================================");

          AppLogger.debugPrint("BACKEND PAYMENT URL:");

          AppLogger.debugPrint(qrUpiUrl);

          AppLogger.debugPrint("QR UPI URL:");

          AppLogger.debugPrint(qrUpiUrl);

          AppLogger.debugPrint("==========================================");

          // If we couldn't create a proper UPI URL,
          // don't show an invalid QR.
          if (!isValidUpiUrl(qrUpiUrl)) {
            CustomToast.error("Invalid UPI payment link received from server");

            AppLogger.debugPrint("Invalid QR UPI URL: $qrUpiUrl");

            return;
          }

          // Start payment timer
          startTimer(ekqrData?.txnId ?? wordlinkData?.txnId ?? '');

          // Load installed UPI apps
          loadInstalledUpiApps();

          // --------------------------------------------------------------
          // SHOW QR POPUP
          // --------------------------------------------------------------

          Get.dialog(
            AddWalletPopup(
              ekqrData: response.ekqr,
              bankData: response.worldline,

              // Keep backend links for buttons
            ),
          ).then((_) async {
            stopTimer();

            amountController.clear();

            await Future.delayed(const Duration(seconds: 1));

            await getWalletHistory();
          });
        },
      );
    } catch (e) {
      AppLogger.debugPrint("Create QR error: $e");

      CustomToast.error("Unable to create payment QR");
    } finally {
      isLoading.value = false;

      update();
    }
  }

  void startWorldlinePayment(Worldline worldlineData) {
    String deviceID = "";
    if (Platform.isAndroid) {
      deviceID = "AndroidSH2";
    } else if (Platform.isIOS) {
      deviceID = "iOSSH2";
    }

    var reqJson = {
      "features": {
        "enableAbortResponse": true,
        "enableExpressPay": false,
        "enableInstrumentDeRegistration": true,
        "enableMerTxnDetails": true,
      },
      "consumerData": {
        "deviceId": deviceID,
        "token": worldlineData.data?.token ?? "",
        "paymentMode": "UPI",
        "merchantLogoUrl":
            "https://drive.usercontent.google.com/download?id=112ShvsWovoUbPulhrob690NuA_GbnWEJ",
        "merchantId": worldlineData.data?.merchantId ?? "",
        "currency": "INR",
        "consumerId": worldlineData.data?.consumerId ?? "",
        "consumerMobileNo": worldlineData.data?.consumerMobileNo ?? "",
        "consumerEmailId": worldlineData.data?.consumerEmailId ?? "",
        "txnId": worldlineData.txnId ?? "",
        "items": [
          {
            "itemId": "first",
            "amount": worldlineData.amount ?? "0",
            "comAmt": "0",
          },
        ],
        "customStyle": {
          "PRIMARY_COLOR_CODE":
              "#${AppColors.clrPrimary.toARGB32().toRadixString(16).substring(2, 8).toUpperCase()}",
          "SECONDARY_COLOR_CODE":
              "#${AppColors.clrBg.toARGB32().toRadixString(16).substring(2, 8).toUpperCase()}",
          "BUTTON_COLOR_CODE_1":
              "#${AppColors.clrSecondary.toARGB32().toRadixString(16).substring(2, 8).toUpperCase()}",
          "BUTTON_COLOR_CODE_2": "#FFFFFF",
        },
      },
    };

    wlCheckout.open(reqJson);
  }

  // --------------------------------------------------------------------------
  // CONVERT BACKEND URL TO STANDARD UPI URL
  // --------------------------------------------------------------------------

  String buildWorkingUpiUrl({
    required String paymentLink,
    required String amount,
  }) {
    final uri = Uri.tryParse(paymentLink);

    if (uri == null) {
      return '';
    }

    final params = uri.queryParameters;

    final pa = params['pa'];
    final pn = params['pn'];

    if (pa == null || pa.isEmpty) {
      return '';
    }

    final queryParams = <String, String>{
      'pa': pa,
      'pn': pn ?? 'AJ SYSTEMS & SERVICES',
      'am': amount,
      'cu': 'INR',
    };

    if (params.containsKey('tn')) queryParams['tn'] = params['tn']!;
    if (params.containsKey('tr')) queryParams['tr'] = params['tr']!;

    final upiUri = Uri(
      scheme: 'upi',
      host: 'pay',
      queryParameters: queryParams,
    );

    return upiUri.toString();
  }

  String convertToStandardUpiUrl(String backendUrl) {
    try {
      final uri = Uri.tryParse(backendUrl);

      if (uri == null) {
        return '';
      }

      final params = uri.queryParameters;

      final pa = params['pa'];

      if (pa == null || pa.isEmpty) {
        debugPrint("UPI ID not found");
        return '';
      }

      final pn = params['pn'] ?? 'AJ SYSTEMS AND SERVICES';

      final amount = params['am'] ?? _lastAmount;

      final queryParams = <String, String>{
        'pa': pa,
        'pn': pn,
        'am': amount,
        'cu': 'INR',
      };

      if (params.containsKey('tn')) queryParams['tn'] = params['tn']!;
      if (params.containsKey('tr')) queryParams['tr'] = params['tr']!;

      final upiUri = Uri(
        scheme: 'upi',
        host: 'pay',
        queryParameters: queryParams,
      );

      debugPrint("QR URL = ${upiUri.toString()}");

      return upiUri.toString();
    } catch (e) {
      debugPrint("UPI conversion error: $e");
      return '';
    }
  }
  // --------------------------------------------------------------------------
  // VALIDATE UPI URL
  // --------------------------------------------------------------------------

  bool isValidUpiUrl(String value) {
    try {
      final uri = Uri.tryParse(value);

      if (uri == null) {
        return false;
      }

      if (uri.scheme.toLowerCase() != 'upi') {
        return false;
      }

      if (uri.host.toLowerCase() != 'pay') {
        return false;
      }

      final pa = uri.queryParameters['pa'];

      if (pa == null || pa.trim().isEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  // --------------------------------------------------------------------------
  // LOAD INSTALLED UPI APPS
  // --------------------------------------------------------------------------

  Future<void> loadInstalledUpiApps() async {
    isLoadingUpiApps.value = true;

    try {
      upiApps.value = await getInstalledUpiApps();

      AppLogger.debugPrint("UPI apps found: ${upiApps.length}");
    } catch (e) {
      AppLogger.debugPrint("UPI apps loading error: $e");
    } finally {
      isLoadingUpiApps.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> getInstalledUpiApps() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        "getInstalledUpiApps",
      );

      return result.map((e) => Map<String, dynamic>.from(e)).toList();
    } on PlatformException catch (e) {
      AppLogger.debugPrint(
        "getInstalledUpiApps PlatformException: "
        "${e.message}",
      );

      return [];
    } catch (e) {
      AppLogger.debugPrint("getInstalledUpiApps error: $e");

      return [];
    }
  }



  Future<void> openSpecificUpiApp({
    required String packageName,
    required String url,
  }) async {
    try {
      print("========== OPEN UPI ==========");
      print("Package: $packageName");
      print("UPI URL: $url");

      final uri = Uri.parse(url);

      final intent = AndroidIntent(
        action: 'android.intent.action.VIEW',
        data: uri.toString(),
        package: packageName,
      );

      await intent.launch();

      print("UPI launch result: true");
      print("========== OPEN UPI END ==========");
    } catch (e) {
      print("UPI launch error: $e");
    }
  }
  // --------------------------------------------------------------------------
  // WALLET HISTORY
  // --------------------------------------------------------------------------

  Future<void> getWalletHistory() async {
    isLoading.value = true;

    update();

    try {
      final result = await createQrUsecase.getWalletHistory();

      result.fold(
        (failure) {
          AppLogger.debugPrint(
            "------------ GET WALLET HISTORY FAILED ------------",
          );

          AppLogger.logError(failure.message);

          CustomToast.error(failure.message);
        },
        (response) {
          AppLogger.debugPrint(
            "------------ GET WALLET HISTORY SUCCESS ------------",
          );

          AppLogger.logError(response.toJson());

          walletQrHistory.value = response;
        },
      );
    } catch (e) {
      AppLogger.debugPrint("Wallet history error: $e");
    } finally {
      isLoading.value = false;

      update();
    }
  }

  // --------------------------------------------------------------------------
  // DISPOSE
  // --------------------------------------------------------------------------

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
