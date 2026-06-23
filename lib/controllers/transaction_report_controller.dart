

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/all_plan.dart';
import 'package:maxpay/core/data/model/submit_dispute_model.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/domain/usecase/all_plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/submit_dispute_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_report_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';



class TransReportController extends GetxController {
  final TransReportUsecase transreportUsecase;
  final AllPlanUsecase allPlanUsecase;
  final SubmitDisputeUsecase submitDisputeUsecase;

  TransReportController({
    required this.transreportUsecase,
    required this.allPlanUsecase,
    required this.submitDisputeUsecase,
  });


RxString selectedProductName = ''.obs;
RxString selectedProductId = ''.obs;
  RxBool isLoading = false.obs;
  String currentStatus = '';

  RxList<TransrepData> transreportList = <TransrepData>[].obs;
Rx<SubmitDisputeData?> disputeData =
    Rx<SubmitDisputeData?>(null);
    Rx<AllPlan?> allplan =
      Rx<AllPlan?>(null);
  String fromDate = '';
String toDate = '';
String search = '';
@override
void onInit() {
  super.onInit();
  fetchplan();
}


 Future<void> fetchplan() async {
    isLoading.value = true;

    final result =
        await allPlanUsecase();

    result.fold(
      (failure) {
        isLoading.value = false;

        Get.snackbar(
          'Error',
          failure.message,
        );
      },
      (data) {
        allplan.value = data;

        isLoading.value = false;
      },
    );
  }

Future<void> transactionreport({
  required String search,
  required String status,
  required String productid,
  required String fromdate,
  required String todate,
}) async {
  try {
    isLoading.value = true;

    AppLogger.debugPrint("===== REQUEST =====");
    AppLogger.debugPrint({
      "search": search,
      "status": status,
      "productid": productid,
      "fromdate": fromdate,
      "todate": todate,
    });

    AppLogger.debugPrint("Calling transreportUsecase...");

    final result = await transreportUsecase(
      search: search,
      status: status,
      productid: productid,
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

        transreportList.assignAll(response.data ?? []);

        AppLogger.debugPrint(
          "Total Records : ${transreportList.length}",
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
    isLoading.value = false;
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
      transactionreport(
  search: search,
  status:currentStatus,
  productid: selectedProductId.value,
  fromdate: fromDate,
  todate: toDate,
);
    }

    update();
  }
}

Future<void> selectToDate(
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
    toDate =
        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

    if (fromDate.isNotEmpty) {
     transactionreport(
  search: search,
  status: currentStatus,
  productid: selectedProductId.value,
  fromdate: fromDate,
  todate: toDate,
);
    }

    update();
  }
}

void onSearch(String value) {
  search = value;

  if (fromDate.isNotEmpty &&
      toDate.isNotEmpty) {
   transactionreport(
  search: search,
  status: currentStatus,
  productid: selectedProductId.value,
  fromdate: fromDate,
  todate: toDate,
);
  }
}





Future<void> SubmitDispute({
  required String subject,
  required String rechargeid,
  required String description,
}) async {
  try {
    isLoading.value = true;

    print("🚀 ===== SUBMIT DISPUTE API =====");
    print("📌 Subject      : $subject");
    print("🆔 Recharge ID  : $rechargeid");
    print("📝 Description  : $description");

    final result = await submitDisputeUsecase(
      description,
      subject,
      rechargeid,
    );

    print("📥 API Response Received");

    result.fold(
      (failure) {
        print("❌ API FAILED");
        print("💥 Error: ${failure.message}");

        CustomToast.error(
          failure.message.toString(),
        );
      },
      (response) {
        print("✅ API SUCCESS");
        print("📦 Response: ${response.toJson()}");

        disputeData.value = response.data;

        print("🆔 Dispute ID: ${response.data?.id}");
        print("📌 Status: ${response.data?.status}");
        print("💬 Message: ${response.message}");

        CustomToast.success(
          response.message ?? "Success",
        );
      },
    );
  } catch (e, stackTrace) {
    print("🔥 EXCEPTION OCCURRED");
    print("❌ Error: $e");
    print("📍 StackTrace: $stackTrace");
  } finally {
    isLoading.value = false;
    print("🏁 Submit Dispute Completed");
  }
}
}