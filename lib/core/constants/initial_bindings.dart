import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_instance/get_instance.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/controllers/app_lifecycle_controller.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
      AuthController(
        loginUseCase: sl(),
        otpUsecase: sl(),
        createPinUsecase: sl(),
        fingerPrintUsecase: sl(),
        verifyPinUsecase: sl(),
      ),
      permanent: true,
    );

    Get.put<AppLifecycleController>(AppLifecycleController(), permanent: true);
    Get.put(TransReportController(transreportUsecase: sl()));
  }
}
