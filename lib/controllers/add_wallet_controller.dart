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

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
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

  // --------------------------------------------------------------------------
  // INIT
  // --------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);

    getWalletHistory();
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
  // CREATE QR
  // --------------------------------------------------------------------------

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

          final txnId = response.txnId ?? '';

          if (txnId.isEmpty) {
            CustomToast.error("Transaction ID not received");
            return;
          }

          // --------------------------------------------------------------
          // IMPORTANT:
          // Convert backend link to standard UPI URI
          // --------------------------------------------------------------

          final backendLink = response.gpayLink ?? '';

          final qrUpiUrl = convertToStandardUpiUrl(backendLink);

          AppLogger.debugPrint("==========================================");

          AppLogger.debugPrint("BACKEND PAYMENT URL:");

          AppLogger.debugPrint(backendLink);

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
          startTimer(txnId);

          // Load installed UPI apps
          loadInstalledUpiApps();

          // --------------------------------------------------------------
          // SHOW QR POPUP
          // --------------------------------------------------------------

          Get.dialog(
            AddWalletPopup(
              amount: amount.trim(),
              txtionId: txnId,

              // IMPORTANT:
              // QR gets standard UPI URI
              url: qrUpiUrl,

              // Keep backend links for buttons
              phonepeLink: response.phonepeLink ?? '',

              gpayLink: response.gpayLink ?? '',
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

  // --------------------------------------------------------------------------
  // OPEN SPECIFIC UPI APP
  // --------------------------------------------------------------------------

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
