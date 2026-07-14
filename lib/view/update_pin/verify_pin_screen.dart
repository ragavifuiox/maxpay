import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/update_pin_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/update_pin_screen.dart';
import 'package:pinput/pinput.dart';

class VerifyPinPage extends StatefulWidget {
  const VerifyPinPage({super.key});

  @override
  State<VerifyPinPage> createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<VerifyPinPage> {
  final TextEditingController otpController = TextEditingController();

  final UpdatePinController controller = Get.put(
    UpdatePinController(
      updatepinusecase: sl(),
      updateSendOtpUsecase: sl(),
      updateotpusecase: sl(),
    ),
  );

  @override
  void initState() {
    super.initState();
    controller.startOtpTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: " "),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GetBuilder<UpdatePinController>(
            builder: (controller) {
              return Column(
                children: [
                  const SizedBox(height: 10),

                  const Text(
                    "Verification code",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lufga',
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Please type the verification code\nsent to +91 000 000 0000",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Center(
                    child: Pinput(
                      controller: otpController,
                      length: 4,
                      keyboardType: TextInputType.number,
                      separatorBuilder: (index) => SizedBox(width: 12.w),
                      defaultPinTheme: PinTheme(
                        width: 56.w,
                        height: 56.h,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xff1BA6C7),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

             Obx(() {
  return controller.canResendOtp.value
      ? GestureDetector(
          onTap: () async {
            await controller.sendUpdatePinOtp();
          },
          child: const Text(
            "Resend OTP",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      : Text(
          "Resend OTP in ${controller.remainingSeconds.value}s",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        );
}),

                  const Spacer(),

                 Obx(
  () => SizedBox(
    width: 170,
    height: 50,
    child: CommonButton(
      title: "Continue",
      width: 170,
      isLoading: controller.isLoading.value,
      onTap: () async {
        if (otpController.text.trim().length != 4) {
          CustomToast.error("Please enter a valid OTP");
          return;
        }

        final success = await controller.verifyOtp(
          otpController.text.trim(),
        );

        if (success) {
          Get.to(() => UpdatePinPage());
        }
      },
    ),
  ),
),

                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}