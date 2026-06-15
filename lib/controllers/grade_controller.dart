import 'package:get/get.dart';
import 'package:maxpay/core/data/model/grade_model.dart';
import 'package:maxpay/core/domain/usecase/grade_usecase.dart';

class GradeController extends GetxController {
  final GradeUsecase gradeusecase;

  GradeController({
    required this.gradeusecase,
  });

  final RxBool isLoading = false.obs;
  final Rxn<Grade> gradeData = Rxn<Grade>();

  @override
  void onInit() {
    super.onInit();
    fetchGrade();
  }

  Future<void> fetchGrade() async {
    try {
      isLoading.value = true;

      final result = await gradeusecase();

      result.fold(
        (failure) {
          Get.snackbar(
            "Error",
            failure.message,
          );
        },
        (data) {
          print("========== GRADE RESPONSE ==========");
          print(data.toJson());

          if (data.data != null && data.data!.isNotEmpty) {
            print("A => ${data.data!.first.a}");
            print("A Balance => ${data.data!.first.aDailyAvgBalance}");
            print("A Cashback => ${data.data!.first.aMonthlyCashback}");
          }

          gradeData.value = data;
        },
      );
    } catch (e) {
      print("GRADE ERROR => $e");
    } finally {
      isLoading.value = false;
    }
  }
}