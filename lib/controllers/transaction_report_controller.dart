

import 'package:flutter/foundation.dart';
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
}