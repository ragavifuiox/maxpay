import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/data/model/today_trnasaction_model.dart';
import 'package:maxpay/core/domain/usecase/product_type_usecase.dart';
import 'package:maxpay/core/domain/usecase/today_trnsaction_usecase.dart';

class ServiceController extends GetxController {
  final ProductTypeUseCase productTypeUseCase;
  final TodayTrnsactionUsecase todayTrnsactionUsecase;

  ServiceController({
    required this.productTypeUseCase,
    required this.todayTrnsactionUsecase,
  });

  RxBool isProductLoading = false.obs;
RxBool isTodayTransactionLoading = false.obs;

  Rx<ProductType?> productTypeData =
      Rx<ProductType?>(null);
      
  Rx<TodayTransaction?> todaytrans =
      Rx<TodayTransaction?>(null);

  @override
  void onInit() {
    fetchProductTypes();
      fetchtodaytrnas();
    super.onInit();
  }

  Future<void> fetchProductTypes() async {
    isProductLoading.value = true;

    final result =
        await productTypeUseCase();

    result.fold(
      (failure) {
        isProductLoading.value = false;

        Get.snackbar(
          'Error',
          failure.message,
        );
      },
      (data) {
        productTypeData.value = data;

        isProductLoading.value = false;
      },
    );
  }
  
  Future<void> fetchtodaytrnas() async {
  isTodayTransactionLoading.value = true;

  final result = await todayTrnsactionUsecase();

  result.fold(
    (failure) {
      isTodayTransactionLoading.value = false;

      print("Today Transaction Error: ${failure.message}");

      Get.snackbar(
        'Error',
        failure.message,
      );
    },
    (data) {
      print("Today Transaction Data: ${data.toJson()}");

      todaytrans.value = data;

      isTodayTransactionLoading.value = false;
    },
  );
}
}