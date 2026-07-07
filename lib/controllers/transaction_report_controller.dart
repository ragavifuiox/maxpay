import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/all_plan.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/data/model/submit_dispute_model.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/domain/usecase/all_plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/product_type_usecase.dart';
import 'package:maxpay/core/domain/usecase/submit_dispute_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_report_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class TransReportController extends GetxController {
  final TransReportUsecase transreportUsecase;
  final ProductTypeUseCase producttypeUseCase;
  final SubmitDisputeUsecase submitDisputeUsecase;

  TransReportController({
    required this.transreportUsecase,
    required this.producttypeUseCase,
    required this.submitDisputeUsecase,
  });

  RxString selectedProductName = ''.obs;
  RxString selectedProductId = ''.obs;
  RxBool isLoading = false.obs;
  String currentStatus = '';
final TextEditingController fromDateController = TextEditingController();
final TextEditingController toDateController = TextEditingController();
  RxList<TransrepData> transreportList = <TransrepData>[].obs;
  Rx<SubmitDisputeData?> disputeData = Rx<SubmitDisputeData?>(null);
  Rx<ProductType?> producttype = Rx<ProductType?>(null);
  String fromDate = '';
String toDate = '';
String search = '';
final TextEditingController searchController = TextEditingController();

@override
void onInit() {
  super.onInit();

  fetchplan();

  final now = DateTime.now();

  fromDate =
      "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

  fromDateController.text = fromDate;

  update(["fromDate"]);
}
void clearFilters() {
  selectedProductId.value = '';
  selectedProductName.value = '';
  fromDate = '';
  toDate = '';
  search = '';
  transreportList.clear();
  update();
}

Future<void> fetchplan() async {
  isLoading.value = true;

  final result = await producttypeUseCase();

  result.fold(
    (failure) {
      Get.snackbar("Error", failure.message);
    },
    (data) {
      producttype.value = data;
      update(); // <-- add this
    },
  );

  isLoading.value = false;
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

          AppLogger.debugPrint("Total Records : ${transreportList.length}");

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

//  Future<void> selectFromDate(BuildContext context) async {
//   DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.parse(fromDate), // today's date initially
//     firstDate: DateTime(2024),
//     lastDate: DateTime(2030),
//   );

//   if (pickedDate != null) {
//     fromDate =
//         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

//     update();

//     if (toDate.isNotEmpty) {
//       transactionreport(
//         search: search,
//         status: currentStatus,
//         productid: selectedProductId.value,
//         fromdate: fromDate,
//         todate: toDate,
//       );
//     }
//   }
// }


Future<void> selectFromDate(BuildContext context) async {
  DateTime initialDate;

  if (fromDate.isEmpty) {
    initialDate = DateTime.now();
  } else {
    try {
      initialDate = DateTime.parse(fromDate);
    } catch (e) {
      initialDate = DateTime.now();
    }
  }

  final pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2024),
    lastDate: DateTime(2030),
  );

  if (pickedDate != null) {
    fromDate =
        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

    fromDateController.text = fromDate;

    update(["fromDate"]);

    transactionreport(
      search: search,
      status: currentStatus,
      productid: selectedProductId.value,
      fromdate: fromDate,
      todate: toDate,
    );
  }
}
  // Future<void> selectToDate(BuildContext context) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2024),
  //     lastDate: DateTime(2030),
  //   );

  //   if (pickedDate != null) {
  //     toDate =
  //         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

  //     if (fromDate.isNotEmpty) {
  //       transactionreport(
  //         search: search,
  //         status: currentStatus,
  //         productid: selectedProductId.value,
  //         fromdate: fromDate,
  //         todate: toDate,
  //       );
  //     }

  //     update();
  //   }
  // }



Future<void> selectToDate(BuildContext context) async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime(2030),
  );

  if (pickedDate != null) {
  toDate =
      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

  toDateController.text = toDate;

  update(["toDate"]);

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

          CustomToast.error(failure.message.toString());
        },
        (response) {
          print("✅ API SUCCESS");
          print("📦 Response: ${response.toJson()}");

          disputeData.value = response.data;

          print("🆔 Dispute ID: ${response.data?.id}");
          print("📌 Status: ${response.data?.status}");
          print("💬 Message: ${response.message}");

          CustomToast.success(response.message ?? "Success");
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

@override
void onClose() {
  fromDateController.dispose();
  toDateController.dispose();
  searchController.dispose();
  super.onClose();
}

}
