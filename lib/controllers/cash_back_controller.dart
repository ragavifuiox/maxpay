import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/all_plan.dart';
import 'package:maxpay/core/data/model/cash_back_model.dart';
import 'package:maxpay/core/domain/usecase/all_plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/cash_back_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';


class CashbackController extends GetxController {
  final AllPlanUsecase allPlanUsecase;
  final CashBackUsecase cashbackUsecase;

  CashbackController({
    required this.allPlanUsecase,
    required this.cashbackUsecase,
  });
RxString selectedProductId = ''.obs;
  RxBool isLoading = false.obs;

  Rx<AllPlan?> allPlan = Rx<AllPlan?>(null);
  Rx<CashBack?> cashBack = Rx<CashBack?>(null);

  RxString selectedProductType = ''.obs;
  RxString selectedProductName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    isLoading.value = true;

    final result = await allPlanUsecase();

    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (data) {
        allPlan.value = data;
      },
    );

    isLoading.value = false;
  }

 Future<void> fetchCashback(
  String productType,
) async {
  try {
    isLoading.value = true;

    AppLogger.debugPrint(
      "===== CASHBACK REQUEST =====",
    );

    AppLogger.debugPrint({
      "productType": productType,
    });

    final result = await cashbackUsecase(
      producttype: productType,
    );

    AppLogger.debugPrint(
      "Cashback Response Received",
    );

    result.fold(
      (failure) {
        AppLogger.logError(
          "CASHBACK FAILURE",
        );

        AppLogger.logError(
          failure.message,
        );

        CustomToast.error(
          failure.message,
        );
      },
      (response) {
        AppLogger.debugPrint(
          "CASHBACK SUCCESS",
        );

        AppLogger.debugPrint(
          response.toJson(),
        );

        cashBack.value = response;

        AppLogger.debugPrint(
          "Total Cashback Records : ${response.code?.length ?? 0}",
        );
      },
    );
  } catch (e, stackTrace) {
    AppLogger.logError(
      "CASHBACK EXCEPTION",
    );

    AppLogger.logError(e);

    AppLogger.logError(stackTrace);
  } finally {
    isLoading.value = false;
  }
}
}