import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/view/login/widgets/custom_numeric_keyboard.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:pinput/pinput.dart';

class ScreenOtpVerification extends StatefulWidget {
  const ScreenOtpVerification({super.key});

  @override
  State<ScreenOtpVerification> createState() =>
      _ScreenOtpVerificationState();
}

class _ScreenOtpVerificationState
    extends State<ScreenOtpVerification> {

  final AuthController authController =
      Get.find<AuthController>();

  final TextEditingController _otpController =
      TextEditingController();

  bool _showVerifyButton = false;

  bool isOtpExpired = false;

  int secondsRemaining = 30;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {

  timer?.cancel();

  timer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {

      if (secondsRemaining > 0) {

        setState(() {
          secondsRemaining--;
        });

      } else {

        setState(() {
          isOtpExpired = true;
        });

        timer.cancel();
      }
    },
  );
}

  @override
  void dispose() {
    timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  /// 🔹 KEYBOARD ACTION
  void _handleKeyPress(String key) {

    setState(() {

      /// 🔹 BACKSPACE
      if (key == 'backspace') {

        /// VERIFY BUTTON SHOWING -> HIDE BUTTON
        if (_showVerifyButton) {

          _showVerifyButton = false;
        }

        if (_otpController.text.isNotEmpty) {

          _otpController.text =
              _otpController.text.substring(
            0,
            _otpController.text.length - 1,
          );
        }
      }

      /// 🔹 NUMBER PRESS
      else {

        if (_otpController.text.length < 4) {

          _otpController.text += key;
        }
      }
    });
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
              maxWidth:
                  isTablet ? 500 : double.infinity,
            ),

            child: Column(
              children: [

                /// 🔹 BACK BUTTON
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),

                  child: Align(
                    alignment: Alignment.centerLeft,

                    child: GestureDetector(
                     onTap: () {

  /// VERIFY BUTTON SHOWING
  if (_showVerifyButton) {

    setState(() {

      /// SHOW KEYBOARD AGAIN
      _showVerifyButton = false;
    });

  }

  /// NORMAL BACK
  else {

    Get.back();
  }
},

                      child: Container(
                        width: 45.w,
                        height: 45.w,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          border: Border.all(
                            color: Colors.grey
                                .withOpacity(0.3),
                          ),
                        ),

                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),

                /// 🔹 CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                    ),

                    child: Column(
                      children: [

                        SizedBox(
                          height:
                              isTablet ? 40.h : 20.h,
                        ),

                        /// 🔹 TITLE
                        Text(
                          'Verification code',

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize:
                                isTablet
                                    ? 28.sp
                                    : 22.sp,
                            color:
                                colorScheme.onSurface,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        /// 🔹 SUBTITLE
                        Obx(
                          () => Text(
                            "Please type the verification code\nsent to ${authController.phoneNumber.value}",

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight:
                                  FontWeight.w400,
                              fontSize:
                                  isTablet
                                      ? 16.sp
                                      : 14.sp,
                              color:
                                  AppColors.clrTextgrey,
                              height: 1.5,
                            ),
                          ),
                        ),

                        SizedBox(height: 40.h),

                        /// 🔹 OTP FIELD
                        Pinput(
                          length: 4,
                          controller: _otpController,
                          readOnly: true,

                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          submittedPinTheme: PinTheme(
                            width:
                                isTablet
                                    ? 70.w
                                    : 60.w,

                            height:
                                isTablet
                                    ? 70.w
                                    : 60.w,

                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize:
                                  isTablet
                                      ? 28.sp
                                      : 24.sp,
                              fontWeight:
                                  FontWeight.w600,
                              color:
                                  AppColors.clrBg,
                            ),

                            decoration:
                                const BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  AppColors.clrPrimary,
                            ),
                          ),

                          defaultPinTheme: PinTheme(
                            width:
                                isTablet
                                    ? 70.w
                                    : 60.w,

                            height:
                                isTablet
                                    ? 70.w
                                    : 60.w,

                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize:
                                  isTablet
                                      ? 28.sp
                                      : 24.sp,
                              fontWeight:
                                  FontWeight.w600,
                              color:
                                  colorScheme.onSurface,
                            ),

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  colorScheme.surfaceBright,
                            ),
                          ),

                          focusedPinTheme: PinTheme(
                            width:
                                isTablet
                                    ? 70.w
                                    : 60.w,

                            height:
                                isTablet
                                    ? 70.w
                                    : 60.w,

                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize:
                                  isTablet
                                      ? 28.sp
                                      : 24.sp,
                              fontWeight:
                                  FontWeight.w600,
                              color:
                                  colorScheme.onSurface,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,

                              border: Border.all(
                                color:
                                    AppColors.clrPrimary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30.h),

                        /// 🔹 TIMER
                        GestureDetector(

  onTap: isOtpExpired
    ? () async {

        /// CLEAR OLD OTP
        _otpController.clear();

        /// HIDE VERIFY BUTTON
        _showVerifyButton = false;

        /// RESEND API
        await authController.resendOtp();

        /// RESET TIMER
        setState(() {

          secondsRemaining = 30;
          isOtpExpired = false;
        });

        /// START TIMER AGAIN
        startTimer();
      }
    : null,

  child: Text(

    isOtpExpired
        ? 'Resend OTP'
        : 'Resend code in 00:$secondsRemaining',

    style: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize:
          isTablet ? 16.sp : 14.sp,

      color: isOtpExpired
          ? Colors.red
          : AppColors.clrPrimary,

      decoration: isOtpExpired
          ? TextDecoration.underline
          : TextDecoration.none,
    ),
  ),
),
                      ],
                    ),
                  ),
                ),

                /// 🔹 KEYBOARD / VERIFY BUTTON
                AnimatedSwitcher(
                  duration:
                      const Duration(milliseconds: 300),

                  child: _showVerifyButton

                      /// 🔹 VERIFY BUTTON
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(
                            24.w,
                            0,
                            24.w,
                            40.h,
                          ),

                          child:
                          CommonButton(
  title: "Verify",
  onTap: () async {
    /// OTP EXPIRED
    if (isOtpExpired) {
      CustomToast.error(
        "OTP Expired. Please resend the OTP.",
      );
      return;
    }

    /// API CALL
    await authController.verifyOtp(
      _otpController.text.trim(),
    );
  },
),
                        )

                      /// 🔹 CUSTOM KEYBOARD
                      : Padding(
                          padding: EdgeInsets.only(
                            bottom: 20.h,
                          ),

                          child: CustomNumericKeyboard(
                            onKeyPressed: (key) {

                              /// 🔹 ARROW CLICK
                            if (key == 'submit') {

  /// OTP EXPIRED
  if (isOtpExpired) {

    CustomToast.error(
      "OTP Expired. Please resend the OTP.",
    );

    return;
  }

  /// EMPTY OTP
  else if (_otpController.text.isEmpty) {

    CustomToast.error(
      "Please enter the OTP",
    );

    return;
  }

  /// LESS THAN 4 DIGITS
  else if (_otpController.text.length < 4) {

    CustomToast.error(
      "Please enter 4 digit OTP",
    );

    return;
  }

  /// SHOW VERIFY BUTTON
  else {

    setState(() {

      _showVerifyButton = true;
    });
  }
}

                              
                              else {

                                _handleKeyPress(key);
                              }
                            },
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