import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/payment_product_model.dart';
import 'package:maxpay/core/data/model/payment_status_model.dart';
import 'package:maxpay/core/domain/usecase/payment_status_type_usecase.dart';
import 'package:maxpay/core/domain/usecase/payment_status_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_payment_status_usecase.dart';

class PaymentStatusController extends GetxController {
  final PaymentStatusUsecase paymentStatusUsecase;
  final CashbackTypeUsecase paymentStatusTypeUsecase;
    final UpdatePaymentStatusUsecase updatePaymentStatusUsecase;

  PaymentStatusController({
    required this.paymentStatusUsecase,
    required this.paymentStatusTypeUsecase,
     required this.updatePaymentStatusUsecase,
  });

  Rx<CashbackProductType?> productTypeData =
      Rx<CashbackProductType?>(null);
  RxBool isLoading = false.obs;
  RxList<PaymentStatusData> paymentstatus =
      <PaymentStatusData>[].obs;

  String fromDate = '';
  String toDate = '';
  String search = '';

  Future<void> getPaymentStatus() async {
    if (fromDate.isEmpty || toDate.isEmpty) return;

    try {
      isLoading.value = true;

      final result = await paymentStatusUsecase(
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
            paymentstatus.value =
                response.data ?? [];

            paymentstatus.refresh();
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
        getPaymentStatus();
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
        getPaymentStatus();
      }

      update();
    }
  }

  void onSearch(String value) {
    search = value;

    if (fromDate.isNotEmpty &&
        toDate.isNotEmpty) {
      getPaymentStatus();
    }
  }


  Future<void> fetchPaymentProductTypes() async {
    isLoading.value = true;

    final result =
        await paymentStatusTypeUsecase();

    result.fold(
      (failure) {
        isLoading.value = false;

        Get.snackbar(
          'Error',
          failure.message,
        );
      },
      (data) {
        productTypeData.value = data;

        isLoading.value = false;
      },
    );
  }

  Future<void> updatePaymentStatus({
  required String rechargeId,
  required String status,
}) async {
  try {
    isLoading.value = true;

    print("========= UPDATE PAYMENT STATUS =========");
    print("Recharge ID : $rechargeId");
    print("Status      : $status");

   final result = await updatePaymentStatusUsecase(
  rechargeId: rechargeId,
  status: status,
);
    print("API Called Successfully");

    result.fold(
      (failure) {
        isLoading.value = false;

        print("API Failed");
        print("Error : ${failure.message}");

        CustomToast.error(failure.message);
      },
      (response) async {
        isLoading.value = false;

        print("API Success");
        print("Success : ${response.success}");
        print("Message : ${response.message}");
        print("Response : $response");

        if (response.success == true) {
          CustomToast.success(
            response.message ?? "Status Updated",
          );

          await getPaymentStatus();
        } else {
          CustomToast.error(
            response.message ?? "Failed",
          );
        }
      },
    );
  } catch (e, stackTrace) {
    isLoading.value = false;

    print("Exception : $e");
    print(stackTrace);
  }
}
}