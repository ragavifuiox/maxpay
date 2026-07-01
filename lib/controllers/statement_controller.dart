import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/statement_model.dart';
import 'package:maxpay/core/domain/usecase/statment_usecase.dart';

class StatementController extends GetxController {
  final StatementUsecase statementUsecase;

  StatementController({
    required this.statementUsecase,
  });
RxString selectedtype = ''.obs;
  RxBool isLoading = false.obs;
  RxList<StatementData> statementlist = <StatementData>[].obs;
final List<String> Type= [
  "Credit",
  "Debit",
];
  String fromDate = '';
  String toDate = '';
  String type = '';
  String search = '';


void setType(String value) {
  selectedtype.value = value;
  type = value.toLowerCase();

  update(); // <-- Add this
}
  Future<void> statement() async {
  if (fromDate.isEmpty || toDate.isEmpty) return;

  try {
    isLoading.value = true;

    debugPrint({
      "type": type,
      "from_date": fromDate,
      "to_date": toDate,
      "search": search,
    }.toString());

    final result = await statementUsecase(
      type: type.isEmpty ? "" : type,
      fromdate: fromDate,
      todate: toDate,
      search: search,
    );

    result.fold(
      (failure) {
        debugPrint("ERROR: ${failure.message}");
      },
      (response) {
        if (response.success == true) {
          statementlist.value = response.data ?? [];
        } else {
          debugPrint("API FAILED: ${response.message}");
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
    initialDate: DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime(2030),
  );

  if (pickedDate != null) {
    fromDate =
        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

    if (toDate.isNotEmpty) {
      statement(); // auto API call
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
      statement(); // auto API call
    }

    update();
  }
}


void onSearch(String value) {
  search = value;

  if (fromDate.isNotEmpty && toDate.isNotEmpty) {
    statement();
  }
}
}