import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/gredit_model.dart';
import 'package:maxpay/core/data/model/wallet_credit_model.dart';
import 'package:maxpay/core/data/model/wallet_credit_type_model..dart';
import 'package:maxpay/core/domain/usecase/credit_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_credit_search_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_credit_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class WalletCreditController extends GetxController {
  final WalletCreditTypeUsecase walletcredittypeusecase;
  final WalletCreditSearchUsecase walletcreditsearchsecase;
  final GetCreditUseCase getCreditUseCase;

  WalletCreditController({
    required this.walletcredittypeusecase,
    required this.walletcreditsearchsecase,
    required this.getCreditUseCase,
  });

  RxString selectedProductName = ''.obs;
  RxString selectedcreditname = ''.obs;
  Rx<Credit?> creditData = Rx<Credit?>(null);
  RxBool isLoading = false.obs;
  String currentStatus = '';

  RxList<CreditData> Searchcredit = <CreditData>[].obs;
  Rx<CreditType?> allplan = Rx<CreditType?>(null);
  String fromDate = '';
  String toDate = '';
  String search = '';
  @override
  void onInit() {
    super.onInit();
    fetchcredittype();
    fetchCredit();
  }

  Future<void> fetchCredit() async {
    isLoading.value = true;

    final result = await getCreditUseCase();

    result.fold(
      (failure) {
        isLoading.value = false;

        Get.snackbar('Error', failure.message);
      },
      (data) {
        creditData.value = data;

        isLoading.value = false;
      },
    );
  }

  Future<void> fetchcredittype() async {
    isLoading.value = true;
print("search = $search");
print("credit = $creditData");
print("fromdate = $fromDate");
print("todate = $toDate");
    final result = await walletcredittypeusecase();

    result.fold(
      (failure) {
        isLoading.value = false;

        Get.snackbar('Error', failure.message);
      },
      (data) {
        allplan.value = data;

        isLoading.value = false;
      },
    );
  }

 Future<void> searchcredit({
  required String search,
  required String credit,
  required String fromdate,
  required String todate,
}) async {
  print("========== API REQUEST ==========");
  print("search : $search");
  print("credit : $credit");
  print("fromdate : $fromdate");
  print("todate : $todate");

  final result = await walletcreditsearchsecase(
    search: search,
    credit: credit,
    fromdate: fromdate,
    todate: todate,
  );

  result.fold(
    (failure) {
      print("API ERROR : ${failure.message}");
    },
    (response) {
      print("API RESPONSE : ${response.toJson()}");
      print("TOTAL RECORDS : ${response.data?.length}");

      Searchcredit.assignAll(response.data ?? []);
    },
  );
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

          credit: selectedcreditname.value,
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

          credit: selectedcreditname.value,
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

    
      searchcredit(
        search: search,

        credit: selectedcreditname.value,
        fromdate: fromDate,
        todate: toDate,
      );
    
  }
}
