import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/view/login/widgets/login_textfield.dart';
import 'package:maxpay/controllers/auth/auth_controller.dart';
import 'package:get/get.dart';

class LoginPhoneNamePage extends GetView<AuthController> {
  const LoginPhoneNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => navigator?.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: colorScheme.onSurface,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Login',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: isTablet ? 24.sp : 18.sp,
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : double.infinity,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isTablet ? 60.h : 40.h),

                  // Phone Number Field
                  PhoneNUmberField(controller: controller.phoneController),

                  SizedBox(height: 16.h),

                  // Name Field
                  LoginTextField(
                    hintText: 'Enter Your Name',
                    controller: controller.nameController,
                  ),

                  SizedBox(height: 16.h),

                  // Pincode Field
                  LoginTextField(
                    hintText: 'Enter Pincode',
                    keyboardType: TextInputType.number,
                    controller: controller.pincodeController,
                  ),

                  SizedBox(height: 24.h),

                  // Terms Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: Obx(() {
                          return Checkbox(
                            value: controller.isAccepted.value,
                            onChanged: (value) {
                              controller.toggleAcceptance(value);
                            },
                            fillColor: WidgetStateProperty.all(
                              Colors.white,
                            ), // white background
                            checkColor: Colors.black, // black tick
                            side: WidgetStateBorderSide.resolveWith((states) {
                              return const BorderSide(
                                color: Colors.black, // ALWAYS black border
                                width: 1.5,
                              );
                            }),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 16.sp : 13.sp,
                              color: colorScheme.onSurface,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Registration implies acceptance of the ',
                              ),
                              const TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: AppColors.clrPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              const TextSpan(
                                text: 'Privacy Policy.',
                                style: TextStyle(
                                  color: AppColors.clrPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Login Button
                  // Center(
                  //   child: CustomElevatedButton(
                  //     text: 'Login',
                  //     width: isTablet ? 300.w : 222.w,
                  //     height: isTablet ? 70.h : 60.h,
                  //     backgroundColor: AppColors.clrPrimary,
                  //     borderRadius: 12.r,
                  //     onPressed: () {
                  //       Get.toNamed(AppRoutes.otpVerification);

                  //     },
                  //   ),
                  // ),
                  Center(
                    child: Obx(() {
                      return CommonButton(
                        title: controller.isSignupLoading.value
                            ? "Loading..."
                            : "Sign Up",
                        onTap: controller.isSignupLoading.value
                            ? () {}
                            : () {
                                controller.signup();
                              },
                      );
                    }),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneNUmberField extends StatelessWidget {
  final TextEditingController? controller;

  const PhoneNUmberField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: isTablet ? 12.h : 4.h,
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            fontFamily: 'Lufga',
            color: theme.colorScheme.onSurface,
            fontSize: isTablet ? 20.sp : 16.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            contentPadding: .only(top: 10.h),
            hintText: 'Your phone no',
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://flagcdn.com/w40/in.png',
                  width: isTablet ? 32.w : 24.w,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.flag, size: isTablet ? 32.w : 24.w),
                ),
                SizedBox(width: 8.w),
                Text(
                  '+91 |',
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    fontWeight: FontWeight.w500,
                    fontSize: isTablet ? 16.sp : 12.sp,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),
            hintStyle: TextStyle(
              fontFamily: 'Lufga',
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              fontSize: isTablet ? 20.sp : 16.sp,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.phone,
        ),
      ),
    );
  }
}
