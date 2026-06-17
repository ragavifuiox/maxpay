import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
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

  AppLogger.logError("API RESULT : $result");

  result.fold(

    (failure) {

      AppLogger.logError("API ERROR : ${failure.message}");

      isLoading.value = false;

      Get.snackbar(
        'Error',
        failure.message,
      );
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



Future<void> searchEarnings(String fromdate, String todate,String search) async {
  try {
    isLoading.value = true;

    final result = await searchEarningsUseCase(
      fromdate: fromdate,
      todate: todate,
      search: search
    );

    result.fold(
      (failure) {
        // CustomToast.error(failure.message);
      },
      (response) async {

        AppLogger.logError("=========== SEARCH EARNINGS RESPONSE ===========");
        AppLogger.logError("SUCCESS : ${response.success}");
        AppLogger.logError("MESSAGE : ${response.message}");
        AppLogger.logError("===========================================");

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