import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/domain/usecase/earning_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/product_type_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_earnings_usecase.dart';

class EarningController extends GetxController {
  final GetEarningsUseCase getEarningsUseCase;
  final SearchEarningsUsecase searchEarningsUseCase;

  EarningController({
    required this.getEarningsUseCase,
    required this.searchEarningsUseCase,
  });

  RxBool isLoading = false.obs;

  Rx<Earnings?> earningsData =
      Rx<Earnings?>(null);

  @override
  void onInit() {
    fetchEarnings();
    super.onInit();
  }

  Future<void> fetchEarnings() async {

  isLoading.value = true;

  final result = await getEarningsUseCase();

  print("API RESULT : $result");

  result.fold(

    (failure) {

      print("API ERROR : ${failure.message}");

      isLoading.value = false;

      Get.snackbar(
        'Error',
        failure.message,
      );
    },

    (data) {

      print("FULL DATA : ${data.toJson()}");

      print("SUCCESS : ${data.success}");

      print("MESSAGE : ${data.message}");

      print("TOTAL EARNINGS : ${data.data?.totalEarnings}");

      print("TYPE : ${data.data?.totalEarnings.runtimeType}");

      earningsData.value = data;

      isLoading.value = false;
    },
  );
}



Future<void> searchEarnings(String fromdate, String todate) async {
  try {
    isLoading.value = true;

    final result = await searchEarningsUseCase(
      fromdate: fromdate,
      todate: todate,
    );

    result.fold(
      (failure) {
        // CustomToast.error(failure.message);
      },
      (response) async {

        print("=========== SEARCH EARNINGS RESPONSE ===========");
        print("SUCCESS : ${response.success}");
        print("MESSAGE : ${response.message}");
        print("===========================================");

        if (response.success == true) {

          // CustomToast.success(
          //   response.message ?? "PIN Created Successfully",
          // );

        
        } else {
          // CustomToast.error(
          //   response.message ?? "Failed to create PIN",
          // );
        }
      },
    );

  } finally {
    isLoading.value = false;
  }
}

}