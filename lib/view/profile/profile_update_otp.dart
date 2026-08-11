import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/controllers/update_pin_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/login/login_phone_name.dart';
import 'package:pinput/pinput.dart';

class ProfileUpdateOtp extends StatefulWidget {
  const ProfileUpdateOtp({super.key});

  @override
  State<ProfileUpdateOtp> createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<ProfileUpdateOtp> {
  final TextEditingController otpController = TextEditingController();

  final ProfileController procontroller = Get.put(
    ProfileController(
      getProfileUseCase: sl(),
      profileUpdateUseCase: sl(),
      updateprofileotpusecase: sl(),
    ),
  );

  @override
  void initState() {
    super.initState();
    procontroller.startOtpTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  Obx(
                    () => Text(
                      "Please type the verification code\nsent to +91 ${procontroller.updatedMobile.value}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                    return procontroller.canResendOtp.value
                        ? GestureDetector(
                            onTap: () async {
                              // If there is an API to resend, it needs to be hooked up here
                              // await procontroller.resendOtp();
                            },
                            child: const Text(
                              "Resend OTP",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        : Text(
                            "Resend OTP in ${procontroller.remainingSeconds.value}s",
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
                        isLoading: procontroller.isLoading.value,
                        onTap: () async {
                          if (otpController.text.trim().length != 4) {
                            CustomToast.error("Please enter a valid OTP");
                            return;
                          }

                          final success = await procontroller.verifyOtp(
                            otpController.text.trim(),
                          );

                          if (success) {
                            await procontroller.fetchProfile();
                            Get.offAll(() => LoginPhoneNamePage());
                          } else {
                            CustomToast.error("Invalid OTP");
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
