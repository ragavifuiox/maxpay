import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/search_staff_model.dart' hide Data;
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/data/model/wallet_report_model.dart';
import 'package:maxpay/core/data/model/wallet_transfer_model.dart';
import 'package:maxpay/core/domain/usecase/addd_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/staff_list_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_report_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_transfer_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class AddStaffController extends GetxController {
  final AddStaffUsecase addStaffUsecase;
  final StaffListUseCase staffListUseCase;
  final StaffTrnsTeportListUseCase staffTrnsTeportListUseCase;
  final SearchStaffUsecase searchStaffUsecase;
  final WalletTransferUsecase walletTransferUsecase;
  final WalletReportUsecase walletReportUsecase;

  AddStaffController({
    required this.addStaffUsecase,
    required this.staffListUseCase,
    required this.searchStaffUsecase,
    required this.walletTransferUsecase,
    required this.walletReportUsecase,
    required this.staffTrnsTeportListUseCase,
  });
  @override
  void onInit() {
    stafflist();
    super.onInit();
  }

  String fromDate = '';
  String toDate = '';
  String search = '';
  final staff = <Data>[].obs;
  final searchStaffData = <SearchStaffData>[].obs;
  final wallettransfer = <TransferData>[].obs;
RxString selectedcreditname = ''.obs;

RxString selectedPaymentType = "Wallet Transfer".obs;
final List<String> walletTypes = [
  "Wallet Transfer",
  "Wallet Reverse",
];

  RxList<WalReportData> walletreport = <WalReportData>[].obs;
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController packageController = TextEditingController();
  // ================= ADD STAFF =================
  Future<void> addstaff(String name, String mobile, String package) async {
    try {
      isLoading = true;
      update();

      AppLogger.logError("=========== REQUEST DATA ===========");
      AppLogger.logError("NAME : $name");
      AppLogger.logError("MOBILE : $mobile");
      AppLogger.logError("PACKAGE : $package");
      AppLogger.logError("===================================");

      final result = await addStaffUsecase(name, mobile, package);

      result.fold(
        (failure) {
          AppLogger.logError("=========== FAILURE ===========");
          AppLogger.logError(failure.message);
          AppLogger.logError("================================");

          CustomToast.error(failure.message);
        },
        (response) {
          AppLogger.logError("=========== BACKEND RESPONSE ===========");
          AppLogger.logError("SUCCESS : ${response.success}");
          AppLogger.logError("MESSAGE : ${response.message}");
          AppLogger.logError("FULL RESPONSE : $response");
          AppLogger.logError("========================================");

          if (response.success == true) {
            CustomToast.success(response.message ?? "Staff Added Successfully");

            Get.back(result: true);
            Get.find<AddStaffController>().stafflist();
          } else {
            CustomToast.error(response.message ?? "Failed to Add Staff");
          }
        },
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> searchStaff(String mobile) async {
    try {
      isLoading = true;
      update();

      AppLogger.logError("Searching Mobile: $mobile");

      final result = await searchStaffUsecase(mobile);

      result.fold(
        (failure) {
          AppLogger.logError("FAILURE: ${failure.message}");
          CustomToast.error(failure.message);
        },
        (response) {
          AppLogger.logError("SUCCESS: ${response.success}");
          AppLogger.logError("NAME: ${response.data?.data?.retailerName}");

          if (response.success == true) {
            nameController.text = response.data?.data?.retailerName ?? '';
            packageController.text =
                response.data?.data?.commissionPackage ?? '';

            AppLogger.logError("TEXT SET: ${nameController.text}");
          } else {
            nameController.clear();
            packageController.clear();
          }

          update();
        },
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // ================= STAFF LIST =================
  Future<void> stafflist() async {
    try {
      isLoading = true;
      update();

      final result = await staffListUseCase();

      result.fold(
        (failure) {
        
        },
        (data) {
          staff.value = data.data ?? [];
        },
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> walletTransfer({
    required String staffid,
    required String amount,
    required String paymenttype,
  }) async {
    try {
      isLoading = true;
      update();

    print("===== Wallet Transfer API =====");
    print("Staff ID: $staffid");
    print("Amount: $amount");
    print("Payment Type: $paymenttype");

    final result = await walletTransferUsecase(
      staffid,
      paymenttype,
      amount,
    );

    print("API CALLED SUCCESSFULLY");

    result.fold(
      (failure) {
        print("API FAILED");
        print("Error Message: ${failure.message}");

        CustomToast.error(failure.message);
      },
      (response) async {
        print("API RESPONSE RECEIVED");
        print("Success: ${response.success}");
        print("Message: ${response.message}");
        print("Response: $response");

        if (response.success == true) {
          CustomToast.success(
            response.message ?? "Wallet Transfer Successful",
          );

          print("Refreshing Wallet Balance...");

          await Get.find<HomePageController>()
              .fetchWalletBalance();

          print("Wallet Balance Refreshed");

          update();
        } else {
          print("Transfer Failed");

          CustomToast.error(
            response.message ?? "Transfer Failed",
          );
        }
      },
    );
  } catch (e, stackTrace) {
    print("EXCEPTION OCCURRED");
    print(e);
    print(stackTrace);

    // CustomToast.error(
    //   "Something went wrong. Please try again.",
    // );
  } finally {
    isLoading = false;
    update();

    print("Loading Finished");
  }
}



  Future<void> searchcredit({
    required String search,

    required String paymenttype,
    required String fromdate,
    required String todate,
  }) async {
    try {
      isLoading = true;
      update();

      AppLogger.debugPrint("===== REQUEST =====");
      AppLogger.debugPrint({
        "search": search,

        "paymenttype": paymenttype,
        "fromdate": fromdate,
        "todate": todate,
      });

      AppLogger.debugPrint("Calling transreportUsecase...");

      final result = await walletReportUsecase(
        search: search,

        paymenttype: paymenttype,
        fromdate: fromdate,
        todate: todate,
      );

      AppLogger.debugPrint("Usecase Response Received");

      result.fold(
        (failure) {
          AppLogger.logError("FAILURE");
          AppLogger.logError(failure.message);

          CustomToast.error(failure.message.toString());
        },
        (response) {
          AppLogger.debugPrint("SUCCESS");

          AppLogger.debugPrint(response.toJson());

          walletreport.assignAll(response.data ?? []);

          AppLogger.debugPrint("Total Records : ${walletreport.length}");

          // CustomToast.success(
          //   response.message ?? "Success",
          // );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.logError("EXCEPTION");
      AppLogger.logError(e);
      AppLogger.logError(stackTrace);
    } finally {
      isLoading = false;
      update();
    }
  }

  Rx<TransactionReport> transReport = TransactionReport().obs;
  Future<void> getStaffTransactionReport({
    required String? prdt,
    required String? search,
    required String? fromdate,
    required String? todate,
    required String? status,
  }) async {
    try {
      isLoading = true;
      update();

      AppLogger.debugPrint("===== REQUEST =====");
      AppLogger.debugPrint({
        "search": search,
        "product_id": prdt,
        "fromdate": fromdate,
        "todate": todate,
        "status": status,
      });

      AppLogger.debugPrint("Calling transreportUsecase...");

      final result = await staffTrnsTeportListUseCase.call(
        prdt,
        fromDate,
        toDate,
        search,
        status,
      );

      AppLogger.debugPrint("Usecase Response Received");

      result.fold(
        (failure) {
          AppLogger.logError("FAILURE");
          AppLogger.logError(failure.message);

          // CustomToast.error(failure.message.toString());
        },
        (response) {
          // CustomToast.success(response.message ?? "Success");
          transReport.value = response;
        },
      );
    } catch (e, stackTrace) {
      AppLogger.logError("EXCEPTION");
      AppLogger.logError(e);
      AppLogger.logError(stackTrace);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> selectFromDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      fromDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

      if (toDate.isNotEmpty) {
        searchcredit(
          search: search,
          paymenttype: selectedcreditname.value,
          fromdate: fromDate,
          todate: toDate,
        );
      }

      update();
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      toDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

      if (fromDate.isNotEmpty) {
        searchcredit(
          search: search,
          paymenttype: selectedcreditname.value,
          fromdate: fromDate,
          todate: toDate,
        );
      }

      update();
    }
  }

  void onSearch(String value) {
    search = value;
    debugPrint("😊Search = $search");

    if (fromDate.isNotEmpty && toDate.isNotEmpty) {
      searchcredit(
        search: search,
        paymenttype: selectedcreditname.value,
        fromdate: fromDate,
        todate: toDate,
      );
    }
  }
}
