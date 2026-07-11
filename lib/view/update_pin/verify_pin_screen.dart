import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
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

  final AuthController authController = Get.put(
    AuthController(
      loginUseCase: sl(),
      otpUsecase: sl(),
      createPinUsecase: sl(),
      fingerPrintUsecase: sl(),
      verifyPinUsecase: sl(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: " ",
       
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// Title
              const Text(
                "Verification code",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
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
                  height: 1.5,
                  fontFamily: 'Lufga',
                ),
              ),

              const SizedBox(height: 40),

              /// OTP
              Pinput(
                controller: otpController,
                length: 4,
                keyboardType: TextInputType.number,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff1BA6C7),
                    shape: BoxShape.circle,
                  ),
                ),

                focusedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff1BA6C7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),

                submittedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
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

              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  // Resend OTP
                },
                child: const Text(
                  "Resend Otp",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const Spacer(),

              Obx(
                () => SizedBox(
                  width: 170,
                  height: 50,
                  child: CommonButton(
                    title: "Continue",
                    width: 170,
                    isLoading: authController.isLoading.value,
                    onTap: () async {
                      final success = await authController.verifyPin(
                        otpController.text.trim(),
                      );

                      if (success) {
                        Get.to(() =>  UpdatePinPage());
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}