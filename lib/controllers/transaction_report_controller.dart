

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/domain/usecase/trans_report_usecase.dart';



class TransReportController extends GetxController {
  final TransReportUsecase transreportUsecase;

  TransReportController({
    required this.transreportUsecase,
  });

  RxBool isLoading = false.obs;

  RxList<TransrepData> transreportList = <TransrepData>[].obs;
  String fromDate = '';
String toDate = '';
String search = '';

  Future<void> transactionreport({
    required String search,
    required String status,
    required String productid,
    required String fromdate,
    required String todate,
  }) async {
    try {
      isLoading.value = true;

      final result = await transreportUsecase(
        search: search,
        status: status,
        productid: productid,
        fromdate: fromdate,
        todate: todate,
      );

     result.fold(
  (failure) {
    CustomToast.error(failure.message.toString());
  },
  (response) {

    transreportList.assignAll(response.data ?? []);

    CustomToast.success(
      response.message ?? "Success",
    );

    debugPrint(
      "Total Records : ${transreportList.length}",
    );
  },
);
    } catch (e) {
      CustomToast.error(e.toString());
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
        status: '',
        productid: '',
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
        status: '',
        productid: '',
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
      status: '',
      productid: '',
      fromdate: fromDate,
      todate: toDate,
    );
  }
}
}