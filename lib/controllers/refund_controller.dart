import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/refund_model.dart';
import 'package:maxpay/core/domain/usecase/refund_usecase.dart';

class RefundController extends GetxController {
  final RefundUsecase refundUsecase;

  RefundController({
    required this.refundUsecase,
  });
@override
void onInit() {
  super.onInit();

  final today = DateTime.now();

  final todayDate =
      "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

  fromDate = todayDate;
  toDate = todayDate;

  getPaymentStatus();
}
  RxBool isLoading = false.obs;
  RxList<RefundData> refund =
      <RefundData>[].obs;

  String fromDate = '';
  String toDate = '';
  String search = '';

  Future<void> getPaymentStatus() async {
    if (fromDate.isEmpty || toDate.isEmpty) return;

    try {
      isLoading.value = true;

      final result = await refundUsecase(
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
          if (response.success == true) {
            refund.value =
                response.data ?? [];

            refund.refresh();
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

 Future<void> selectFromDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: fromDate.isNotEmpty
        ? DateTime.parse(fromDate)
        : DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime(2030),
  );

  if (pickedDate != null) {
    fromDate =
        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

    getPaymentStatus();

    update();
  }
}

Future<void> selectToDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: toDate.isNotEmpty
        ? DateTime.parse(toDate)
        : DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime(2030),
  );

  if (pickedDate != null) {
    toDate =
        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

    getPaymentStatus();

    update();
  }
}

  void onSearch(String value) {
  search = value;
  getPaymentStatus();
}
}