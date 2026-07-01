import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/update_pin_screen.dart';
import 'package:maxpay/view/update_pin/widget/pin_box_widget.dart';
import 'package:pinput/pinput.dart';

class VerifyPinPage extends StatefulWidget {
  const VerifyPinPage({super.key});

  @override
  State<VerifyPinPage> createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<VerifyPinPage> {
  final TextEditingController pinController = TextEditingController();

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 500 : double.infinity,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 48.h : 24.h),

                Text(
                  'Enter your OTP',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 30.sp : 22.sp,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 8.h),
                // Text(
                //   'Please enter your 4-digit security PIN to access your account.',
                //   style: TextStyle(
                //     fontFamily: 'Poppins',
                //     fontWeight: FontWeight.w400,
                //     fontSize: isTablet ? 18.sp : 13.sp,
                //     color: colorScheme.onSurface.withOpacity(0.6),
                //   ),
                // ),

                SizedBox(height: isTablet ? 56.h : 40.h),

                Center(
                  child: Pinput(
                    length: 4,
                    controller: pinController,
                    readOnly: false,
                    defaultPinTheme: PinTheme(
                      width: isTablet ? 72.w : 58.w,
                      height: isTablet ? 72.w : 58.w,
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: isTablet ? 28.sp : 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,
                      shape:.circle,
                        // borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.clrPrimary.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: isTablet ? 72.w : 58.w,
                      height: isTablet ? 72.w : 58.w,
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: isTablet ? 28.sp : 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,
                        shape: .circle,
                        // borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isTablet ? 40.h : 32.h),

                Spacer(),
                Obx(
                  () => CommonButton(
                    title: "Verify",
                    width: Get.width,
                    isLoading: authController.isLoading.value,
                    onTap: () async {
                      final success = await authController.verifyPin(
                        pinController.text.trim(),
                      );
                      if (success) {
                        Get.to(() => UpdatePinPage());
                      }
                    },
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
