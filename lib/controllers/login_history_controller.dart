import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/login_history_model.dart';
import 'package:maxpay/core/data/model/payment_status_model.dart';
import 'package:maxpay/core/data/model/refund_model.dart';
import 'package:maxpay/core/domain/usecase/login_history_usecase.dart';
import 'package:maxpay/core/domain/usecase/payment_status_usecase.dart';
import 'package:maxpay/core/domain/usecase/refund_usecase.dart';

class LoginHistoryController extends GetxController {
  final LoginHistoryUsecase loginHistoryUsecase;

  LoginHistoryController({
    required this.loginHistoryUsecase,
  });

  RxBool isLoading = false.obs;
  RxList<LogHistoryData> loghistory =
      <LogHistoryData>[].obs;

  String fromDate = '';
  String toDate = '';
  String search = '';

  Future<void> LoginHistory() async {
    if (fromDate.isEmpty || toDate.isEmpty) return;

    try {
      isLoading.value = true;

      final result = await loginHistoryUsecase(
        toDate,
        fromDate,
        search,
      );

      result.fold(
        (failure) {
          CustomToast.error(
            failure.message.toString(),
          );
        },
        (response) {
         if (response.status == true) {
  loghistory.value = response.data ?? [];

  loghistory.refresh();
} else {
  CustomToast.error(
    response.message ?? "No data found",
  );
}
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectFromDate(
      BuildContext context) async {
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
        LoginHistory();
      }

      update();
    }
  }

  Future<void> selectToDate(
      BuildContext context) async {
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
        LoginHistory();
      }

      update();
    }
  }

  void onSearch(String value) {
    search = value;

    if (fromDate.isNotEmpty &&
        toDate.isNotEmpty) {
      LoginHistory();
    }
  }
}