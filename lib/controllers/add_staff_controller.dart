import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/search_staff_model.dart' hide Data;
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
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
  final SearchStaffUsecase searchStaffUsecase;
  final WalletTransferUsecase walletTransferUsecase;
  final WalletReportUsecase walletReportUsecase;
  

  AddStaffController({
    required this.addStaffUsecase,
    required this.staffListUseCase,
    required this.searchStaffUsecase,
    required this.walletTransferUsecase,
    required this.walletReportUsecase,
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
          CustomToast.error(failure.message);
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

   final result = await walletTransferUsecase(
  staffid,
  paymenttype,
  amount,
);

    AppLogger.debugPrint("API CALLED SUCCESSFULLY");

    result.fold(
      (failure) {
        CustomToast.error(
          failure.message,
        );

        AppLogger.debugPrint(
          "ERROR: ${failure.message}",
        );
      },
     (response) async {
  if (response.success == true) {

    CustomToast.success(
      response.message ?? "Wallet Transfer Successful",
    );

    // Wallet balance refresh
    await Get.find<HomePageController>()
        .fetchWalletBalance();

    update();

  } else {
    CustomToast.error(
      response.message ?? "Transfer Failed",
    );
  }
}
    );
  } catch (e, stackTrace) {
    AppLogger.debugPrint(
      "EXCEPTION: $e\n$stackTrace",
    );

    CustomToast.error(
      "Something went wrong. Please try again.",
    );
  } finally {
    isLoading = false;
    update();
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

        AppLogger.debugPrint(
          "Total Records : ${walletreport.length}",
        );

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







Future<void> selectFromDate(
  BuildContext context,
) async {
  DateTime? pickedDate =
      await showDatePicker(
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


