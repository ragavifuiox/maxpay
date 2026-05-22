import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/domain/usecase/plan_usecase.dart';
import 'package:maxpay/core/error/failure.dart';

class PrePaidController extends GetxController {
  final PlanUseCase planUseCase;

  PrePaidController({
    required this.planUseCase,
  });

  /// Loading
  RxBool isLoading = false.obs;

  /// Error Message
  RxString errorMessage = ''.obs;

  /// Full Plan Response
  Rx<Plan?> planModel = Rx<Plan?>(null);

  /// Plan List
  RxList<Data> plans = <Data>[].obs;

  /// Selected Plan
  Rx<Data?> selectedPlan = Rx<Data?>(null);

  /// Get Plans API
  Future<void> getPlans({
    required String planId,
  }) async {
    try {
      isLoading.value = true;

      final result = await planUseCase(
        planid: planId,
      );

      result.fold(
        (Failure failure) {
          errorMessage.value = failure.message;

          print(
            "PLAN FAILURE : ${failure.message}",
          );

          CustomToast.error(
            failure.message,
          );
        },

        (Plan response) {
          print(
            "=========== PLAN RESPONSE ===========",
          );

          print(response.message);

          /// Store Full Response
          planModel.value = response;

          /// Store List
          plans.value = response.data ?? [];

          /// Default Selected Item
          if (plans.isNotEmpty) {
            selectedPlan.value = plans.first;
          }

          CustomToast.success(
            response.message ??
                "Plans Loaded Successfully",
          );
        },
      );
    } catch (e) {
      print(
        "PLAN CONTROLLER ERROR : $e",
      );

      errorMessage.value = e.toString();

      CustomToast.error(
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}