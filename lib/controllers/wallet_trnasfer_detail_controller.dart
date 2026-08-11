import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/staff_wallet_reverse_model.dart';
import 'package:maxpay/core/data/model/wallet_trnasfer_detail.dart';
import 'package:maxpay/core/domain/usecase/satff_wallet_reverse_usecase.dart';

import 'package:maxpay/core/domain/usecase/wallet_trnasfer_detail_usecase.dart';
import 'package:maxpay/view/transfer_detail/wallet_trnasfer.dart';

class WalletTrnasferDetailController extends GetxController {
  final WalletTrnasferDetailUsecase walletTransferDetailUseCase;
  final SatffWalletReverseUsecase staffWalletReverseUsecase;

  WalletTrnasferDetailController({
    required this.walletTransferDetailUseCase,
    required this.staffWalletReverseUsecase,
  });

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();


  // Date formats
  final String _apiFormat = 'yyyy-MM-dd';
  final String _displayFormat = 'dd.MM.yyyy';

  Rx<TransferFilterType> selectedFilter = TransferFilterType.walletTransfer.obs;
  RxString transactionType = "".obs;
  RxBool isLoading = false.obs;
  RxDouble totalAmount = 0.0.obs;

  RxString search = ''.obs;

  Rxn<StaffReverse> reverseResponse = Rxn<StaffReverse>();

  // Stored in API format (yyyy-MM-dd)
  String fromDate = '';
  String toDate = '';

  Rxn<WalletTransferDetail> walletTransferDetail = Rxn<WalletTransferDetail>();

  RxList<TransferHistory> transferList = <TransferHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    _setDefaultDatesAndFetch();
  }

  /// Sets from/to date to TODAY by default and fetches the data automatically.
  void _setDefaultDatesAndFetch() {
    final DateTime today = DateTime.now();

    final String apiDate = DateFormat(_apiFormat).format(today);
    final String displayDate = DateFormat(_displayFormat).format(today);

    fromDate = apiDate;
    toDate = apiDate;

    fromDateController.text = displayDate;
    toDateController.text = displayDate;

    // Set default transaction type label based on default selectedFilter
    transactionType.value = selectedFilter.value.label;

    getWalletTransferDetail(
      search: search.value,
      startDate: fromDate,
      endDate: toDate,
      transferType: transactionType.value,
    );
  }

  Future<void> getWalletTransferDetail({
    required String search,
    required String startDate,
    required String endDate,
    required String transferType,
  }) async {
    isLoading.value = true;

    print("========== Wallet Transfer Detail API ==========");
    print("Search         : $search");
    print("Start Date     : $startDate");
    print("End Date       : $endDate");
    print("Transfer Type  : $transferType");

    final result = await walletTransferDetailUseCase(
      search: search,
      startdate: startDate,
      todate: endDate,
      transfertype: transferType,
    );
    result.fold(
      (failure) {
        print("❌ API Failed");
        print("Error : ${failure.message}");

        CustomToast.error(failure.message);
      },
      (data) {

        print("✅ API Success");
        print("Success          : ${data.success}");
        print("Message          : ${data.message}");
        print("Transaction Type : ${data.data?.transactionType}");
        print("Total Amount     : ${data.data?.totalAmount}");
        print("Count            : ${data.data?.count}");



        walletTransferDetail.value = data;

     transferList.assignAll(data.data?.history ?? []);

totalAmount.value =
    double.tryParse(
      data.data?.totalAmount.toString() ?? "0",
    ) ??
    0.0;

print("TOTAL AMOUNT UPDATED => ${totalAmount.value}");
      print("Transfer List Length : ${transferList.length}");

        for (int i = 0; i < transferList.length; i++) {
          final item = transferList[i];

          print("----------- Transaction ${i + 1} -----------");
          print("ID           : ${item.id}");
          print("Txn ID       : ${item.txnId}");
          print("Retailer ID  : ${item.retailerId}");
          print("Staff ID     : ${item.staffId}");
          print("Payment Type : ${item.paymentType}");
          print("Amount       : ${item.amount}");
          print("Created At   : ${item.createdAt}");
          print("Updated At   : ${item.updatedAt}");
        
        }

        print("=============================================");
      },
    );

    isLoading.value = false;
  }

  Future<void> staffWalletReverse({required String id}) async {
    isLoading.value = true;

    print("========== Staff Wallet Reverse API ==========");
    print("ID : $id");

    final result = await staffWalletReverseUsecase(id: id);

    result.fold(
      (failure) {
        print("❌ API Failed");
        print("Error : ${failure.message}");

        CustomToast.error(failure.message);
      },


      (data) {
        print("✅ API Success");
        print("Success      : ${data.success}");
        print("Message      : ${data.message}");
        print("Code         : ${data.code}");

        if (data.data != null) {
          print("----------- Reverse Details -----------");
          print("ID           : ${data.data!.id}");
          print("Retailer ID  : ${data.data!.retailerId}");
          print("Staff ID     : ${data.data!.staffId}");
          print("Payment Type : ${data.data!.paymentType}");
          print("Amount       : ${data.data!.amount}");
          print("Txn ID       : ${data.data!.txnId}");
          print("Created At   : ${data.data!.createdAt}");
          print("Updated At   : ${data.data!.updatedAt}");
        }

        reverseResponse.value = data;

        CustomToast.success(data.message ?? "Wallet Reverse Successful");
      },
    );

    isLoading.value = false;
  }

  Future<void> selectFromDate(BuildContext context) async {
    DateTime initialDate = fromDate.isEmpty
        ? DateTime.now()
        : DateTime.tryParse(fromDate) ?? DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      fromDate = DateFormat(_apiFormat).format(pickedDate);

      fromDateController.text = DateFormat(_displayFormat).format(pickedDate);

      update(["fromDate"]);

      getWalletTransferDetail(
        search: search.value,
        startDate: fromDate,
        endDate: toDate,
        transferType: transactionType.value,
      );
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    DateTime initialDate = toDate.isEmpty
        ? DateTime.now()
        : DateTime.tryParse(toDate) ?? DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    


    if (pickedDate != null) {
      toDate = DateFormat(_apiFormat).format(pickedDate);

      toDateController.text = DateFormat(_displayFormat).format(pickedDate);

      update(["toDate"]);

      getWalletTransferDetail(
        search: search.value,
        startDate: fromDate,
        endDate: toDate,
        transferType: transactionType.value,
      );
    }
  }
}
