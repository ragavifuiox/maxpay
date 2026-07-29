import 'package:get/get.dart';
import 'package:maxpay/core/data/model/grade_model.dart';
import 'package:maxpay/core/domain/usecase/grade_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class GradeController extends GetxController {
  final GradeUsecase gradeusecase;

  GradeController({
    required this.gradeusecase,
  });

  final RxBool isLoading = false.obs;
  final Rxn<RetailorGrade> gradeData = Rxn<RetailorGrade>();

  @override
  void onInit() {
    super.onInit();
    fetchGrade();
  }

 Future<void> fetchGrade() async {
  try {
    AppLogger.debugPrint("1. fetchGrade Started");

    isLoading.value = true;

    AppLogger.debugPrint("2. Before gradeUsecase");

    final result = await gradeusecase();

    AppLogger.debugPrint("3. After gradeUsecase");

    result.fold(
      (failure) {
        AppLogger.debugPrint("4. Failure");
        AppLogger.debugPrint(failure.message);
      },
      (data) {
        AppLogger.debugPrint("5. Success");
        AppLogger.debugPrint(data.toJson().toString());

        gradeData.value = data;
      },
    );
  } catch (e, s) {
    AppLogger.debugPrint("ERROR: $e");
    AppLogger.debugPrint(s.toString());
  } finally {
    isLoading.value = false;
  }
}
}