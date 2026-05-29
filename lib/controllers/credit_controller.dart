import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';
import 'package:maxpay/core/data/model/gredit_model.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/domain/usecase/credit_usecase.dart';
import 'package:maxpay/core/domain/usecase/earning_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/product_type_usecase.dart';

class CreditController extends GetxController {
  final GetCreditUseCase getCreditUseCase;

  CreditController({
    required this.getCreditUseCase,
  });

  RxBool isLoading = false.obs;

  Rx<Credit?> creditData =
      Rx<Credit?>(null);

  @override
  void onInit() {
    fetchCredit();
    super.onInit();
  }

  Future<void> fetchCredit() async {
    isLoading.value = true;

    final result =
        await getCreditUseCase();

    result.fold(
      (failure) {
        isLoading.value = false;

        Get.snackbar(
          'Error',
          failure.message,
        );
      },
      (data) {
        creditData.value = data;

        isLoading.value = false;
      },
    );
  }
}