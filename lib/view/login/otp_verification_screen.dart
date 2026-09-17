import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:maxpay/view/login/widgets/resend_timer_widget.dart';
import 'package:pinput/pinput.dart';

class ScreenOtpVerification extends StatefulWidget {
  const ScreenOtpVerification({super.key});

  @override
  State<ScreenOtpVerification> createState() => _ScreenOtpVerificationState();
}

class _ScreenOtpVerificationState extends State<ScreenOtpVerification> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  void dispose() {
    _otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    print('=== OTP VERIFY TRIGGERED ===');
    final controller = Get.find<AuthController>();

    // Prevent double subm
    //ission if API is already being called
    if (controller.isLoading.value) {
      print('=== ALREADY LOADING, SKIPPING API CALL ===');
      return;
    }

    if (_otpController.text.length == 4) {
      controller.verifyOtp(_otpController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : double.infinity,
            ),
            child: Column(
              children: [
                /// 🔹 HEADER / BACK BUTTON
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => navigator?.pop(),
                      child: Container(
                        width: 45.w,
                        height: 45.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Icon(Icons.arrow_back_ios_new, size: 18.sp),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: isTablet ? 40.h : 20.h),

                        /// 🔹 Title
                        Text(
                          'Verification code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: isTablet ? 28.sp : 22.sp,
                            color: colorScheme.onSurface,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        /// 🔹 Subtitle
                        Text(
                          "Please enter the verification code\nsent to your phone number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: isTablet ? 16.sp : 14.sp,
                            color: AppColors.clrTextgrey,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 40.h),

                        /// 🔹 OTP FIELD (Pinput)
                        Pinput(
                          length: 4,
                          autofocus: false,
                          toolbarEnabled: true,
                          enableInteractiveSelection: true,
                          showCursor: true,

                          contextMenuBuilder: (context, editableTextState) {
                            final original =
                                editableTextState.contextMenuAnchors;

                            final anchors = TextSelectionToolbarAnchors(
                              primaryAnchor: original.primaryAnchor.translate(
                                0,
                                240,
                              ),
                            );

                            return AdaptiveTextSelectionToolbar(
                              anchors: anchors,

                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.clrPrimary,
                                  ),
                                  onPressed: () {
                                    editableTextState.pasteText(
                                      SelectionChangedCause.toolbar,
                                    );

                                    editableTextState.hideToolbar();
                                  },
                                  child: const Text(
                                    'Paste',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                if (_otpController.text.length == 4) ...[
                                  VerticalDivider(color: AppColors.textclr),
                                  TextButton(
                                    onPressed: () {
                                      _otpController.clear();

                                      editableTextState.hideToolbar();

                                      // Optional: remove focus
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: const Text(
                                      'Clear',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          onTap: () => otpFocusNode.requestFocus(),
                          onCompleted: (pin) => _verifyOtp(),
                          mainAxisAlignment: MainAxisAlignment.center,
                          submittedPinTheme: PinTheme(
                            width: isTablet ? 70.w : 60.w,
                            height: isTablet ? 70.w : 60.w,
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 28.sp : 24.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.clrBg,
                            ),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.clrPrimary,
                            ),
                          ),
                          defaultPinTheme: PinTheme(
                            width: isTablet ? 70.w : 60.w,
                            height: isTablet ? 70.w : 60.w,
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 28.sp : 24.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.surfaceBright,
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: isTablet ? 70.w : 60.w,
                            height: isTablet ? 70.w : 60.w,
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 28.sp : 24.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.clrPrimary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// 🔹 Timer
                        ResendTimerWidget(
                          onResend: () {
                            final controller = Get.find<AuthController>();
                            controller.resendOtp();
                          },
                        ),

                        SizedBox(height: 20.h),

                        // 🔹 Paste Button
                      ],
                    ),
                  ),
                ),

                /// VERIFY BUTTON
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.h),
                  child: Obx(
                    () => CustomElevatedButton(
                      text: 'Verify OTP',
                      onPressed: _verifyOtp,
                      isLoading: Get.find<AuthController>().isLoading.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
