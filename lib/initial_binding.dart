import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_instance/get_instance.dart';
import 'package:maxpay/injection_container.dart';
import 'package:maxpay/controllers/auth/auth_controller.dart';
import 'package:maxpay/controllers/home/app_lifecycle_controller.dart';
import 'package:maxpay/core/domain/usecase/send_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/verify_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/create_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/verify_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/signup_send_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/logout_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_fingerprint_usecase.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
      AuthController(
        sendOtpUseCase: sl<SendOtpUseCase>(),
        verifyOtpUseCase: sl<VerifyOtpUseCase>(),
        createPinUseCase: sl<CreatePinUseCase>(),
        verifyPinUseCase: sl<VerifyPinUseCase>(),
        signupSendOtpUseCase: sl<SignupSendOtpUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
        updateFingerprintUseCase: sl<UpdateFingerprintUseCase>(),
      ),
      permanent: true,
    );

    Get.put<AppLifecycleController>(AppLifecycleController(), permanent: true);
    // Get.put(
    //   TransReportController(
    //     transreportUsecase: sl(),
    //     allPlanUsecase: sl(),
    //     submitDisputeUsecase: sl(),
    //   ),
    // );
  }
}
