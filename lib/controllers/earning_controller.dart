import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/data/model/my_earnings_model.dart';
import 'package:maxpay/core/domain/usecase/earning_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_earnings_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class EarningController extends GetxController {
  final GetEarningsUseCase getEarningsUseCase;
  final SearchEarningsUsecase searchEarningsUseCase;

  EarningController({
    required this.getEarningsUseCase,
    required this.searchEarningsUseCase,
  });
RxBool isSearchLoading = false.obs;
  RxBool isLoading = false.obs;
  Rx<SearchEarning?> searchData = Rx<SearchEarning?>(null);
  Rx<Earnings?> earningsData = Rx<Earnings?>(null);
  String fromDate = '';
  String toDate = '';
  String search = '';

  @override
  void onInit() {
    fetchEarnings();
    super.onInit();
  }

  Future<void> fetchEarnings() async {
    isLoading.value = true;

    final result = await getEarningsUseCase();

    AppLogger.logError("API RESULT : $result");

    result.fold(
      (failure) {
        AppLogger.logError("API ERROR : ${failure.message}");

        isLoading.value = false;

        Get.snackbar('Error', failure.message);
      },

      (data) {
        AppLogger.logError("FULL DATA : ${data.toJson()}");

        AppLogger.logError("SUCCESS : ${data.success}");

        AppLogger.logError("MESSAGE : ${data.message}");

        AppLogger.logError("TOTAL EARNINGS : ${data.data?.totalEarnings}");

        AppLogger.logError("TYPE : ${data.data?.totalEarnings.runtimeType}");

        earningsData.value = data;

        isLoading.value = false;
      },
    );
  }

 Future<void> searchEarnings(
  String fromdate,
  String todate,
  String search,
) async {
  try {
    isSearchLoading.value = true;

    print("From Date: $fromdate");
    print("To Date: $todate");
    print("Search: $search");

    final result = await searchEarningsUseCase(
      fromdate: fromdate,
      todate: todate,
      search: search,
    );

    result.fold(
      (failure) {
        print("API Error: ${failure.message}");
      },
      (response) {
        print("API Response: ${response.toJson()}");

        if (response.success == true) {
          searchData.value = response;
          print("List Length: ${response.data?.list?.length}");
        }
      },
    );
  } finally {
    isSearchLoading.value = false;
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
        await searchEarnings(fromDate, toDate, search);
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
        await searchEarnings(fromDate, toDate, search);
      }

      update();
    }
  }

  void onSearch(String value) {
    search = value;

    if (fromDate.isNotEmpty && toDate.isNotEmpty) {
      searchEarnings(fromDate, toDate, search);
    }
  }
}
