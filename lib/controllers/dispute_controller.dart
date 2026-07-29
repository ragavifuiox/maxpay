import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/dispute_model.dart' show Data;
import 'package:maxpay/core/domain/usecase/dispute_usecase.dart';


class DisputeController extends GetxController {
  final DisputeUsecase disputeusecase;

  DisputeController({
    required this.disputeusecase,
  });

  RxBool isLoading = false.obs;
  RxList<Data> disputeList = <Data>[].obs;

  String fromDate = '';
  String toDate = '';

  @override
  void onInit() {
    super.onInit();

    final today = DateTime.now();

    final todayDate =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    // Default today date
    fromDate = todayDate;
    toDate = todayDate;

    // Load today's dispute data
    searchdispute();
  }


  Future<void> searchdispute() async {
    if (fromDate.isEmpty || toDate.isEmpty) return;

    try {
      isLoading.value = true;

      final result = await disputeusecase(
        fromdate: fromDate,
        todate: toDate,
      );

      result.fold(
        (failure) {
          print("ERROR: ${failure.message}");
        },
        (response) {
          print("SUCCESS: ${response.success}");
          print("DATA LENGTH: ${response.data?.length}");

          if (response.success == true) {
            disputeList.assignAll(response.data ?? []);
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
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')}";


      searchdispute();

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
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')}";


      searchdispute();

      update();
    }
  }
}

// class DisputeController extends GetxController {
//   final DisputeUsecase disputeusecase;

//   DisputeController({
//     required this.disputeusecase,
//   });



//   RxBool isLoading = false.obs;
//   RxList<Data> disputeList = <Data>[].obs;

//   String fromDate = '';
//   String toDate = '';

//   Future<void> searchdispute() async {
//     if (fromDate.isEmpty || toDate.isEmpty) return;

//     try {
//       isLoading.value = true;

//       final result = await disputeusecase(
//         fromdate: fromDate,
//         todate: toDate,
//       );

//       result.fold(
//   (failure) {
//     print("ERROR: ${failure.message}");
//   },
//   (response) {
//     print("SUCCESS: ${response.success}");
//     print("DATA LENGTH: ${response.data?.length}");

//     if (response.success == true) {
//       disputeList.value = response.data ?? [];
//       disputeList.refresh();

//       print("DISPUTE LIST LENGTH: ${disputeList.length}");
//     }
//   },
// );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> selectFromDate(BuildContext context) async {
//   DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2024),
//     lastDate: DateTime(2030),
//   );

//   if (pickedDate != null) {
//     fromDate =
//         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

//     if (toDate.isNotEmpty) {
//       searchdispute(); // auto API call
//     }

//     update();
//   }
// }


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
//       searchdispute(); // auto API call
//     }

//     update();
//   }
// }
// }

