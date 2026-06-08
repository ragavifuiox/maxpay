import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/domain/usecase/product_type_usecase.dart';

class ServiceController extends GetxController {
  final ProductTypeUseCase productTypeUseCase;

  ServiceController({
    required this.productTypeUseCase,
  });

  RxBool isLoading = false.obs;

  Rx<ProductType?> productTypeData =
      Rx<ProductType?>(null);

  @override
  void onInit() {
    fetchProductTypes();
    super.onInit();
  }

  Future<void> fetchProductTypes() async {
    isLoading.value = true;

    final result =
        await productTypeUseCase();

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
}