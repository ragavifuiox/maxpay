import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/data/model/support_model.dart';
import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_support_usecase.dart';
import 'package:maxpay/core/domain/usecase/product_type_usecase.dart';

class SupportController extends GetxController {
  final GetSupportUsecase supportUseCase;

  SupportController({
    required this.supportUseCase,
  });

  RxBool isLoading = false.obs;

  Rx<Support?> supportData =
      Rx<Support?>(null);

  @override
  void onInit() {
    fetchSupport();
    super.onInit();
  }

  Future<void> fetchSupport() async {
    isLoading.value = true;

    final result =
        await supportUseCase();

    result.fold(
      (failure) {
        isLoading.value = false;

        Get.snackbar(
          'Error',
          failure.message,
        );
      },
      (data) {
        supportData.value = data;

        isLoading.value = false;
      },
    );
  }
}