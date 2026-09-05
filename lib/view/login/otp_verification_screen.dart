import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:pinput/pinput.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenOtpVerification extends StatefulWidget {
  const ScreenOtpVerification({super.key});

  @override
  State<ScreenOtpVerification> createState() => _ScreenOtpVerificationState();
}

class _ScreenOtpVerificationState extends State<ScreenOtpVerification>
    with WidgetsBindingObserver {
  final TextEditingController _otpController = TextEditingController();
  Set<String> _pastedOtps = {};
  String? _clipboardOtp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPastedOtps().then((_) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _checkClipboardForOtp();
          if (kDebugMode) {
            final authController = Get.find<AuthController>();
            if (authController.otp.value.isNotEmpty) {
              _otpController.text = authController.otp.value;
              _verifyOtp();
            }
          }
        });
      }
    });
  }

  Future<void> _loadPastedOtps() async {
    final prefs = await SharedPreferences.getInstance();
    final String today = DateTime.now().toIso8601String().split('T').first;
    final String storedDate = prefs.getString('pasted_otp_date') ?? '';

    if (storedDate != today) {
      await prefs.setStringList('pasted_otps', []);
      await prefs.setString('pasted_otp_date', today);
      _pastedOtps = {};
    } else {
      final List<String> storedOtps = prefs.getStringList('pasted_otps') ?? [];
      _pastedOtps = storedOtps.toSet();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _otpController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkClipboardForOtp();
    }
  }

  Future<void> _checkClipboardForOtp() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final text = clipboardData?.text?.trim() ?? '';

      if (text.isNotEmpty) {
        final match = RegExp(r'\b\d{4}\b').firstMatch(text);
        if (match != null) {
          final otp = match.group(0)!;
          // Prevent showing for the same OTP repeatedly
          if (!_pastedOtps.contains(otp) && otp != _otpController.text) {
            setState(() {
              _clipboardOtp = otp;
            });
          } else if (_clipboardOtp != null) {
            setState(() {
              _clipboardOtp = null;
            });
          }
        }
      }
    } catch (e) {
      // Graceful degradation: do nothing if clipboard access fails
    }
  }

  Future<void> _onPasteOtp() async {
    if (_clipboardOtp != null) {
      final otpToPaste = _clipboardOtp!;

      _pastedOtps.add(otpToPaste);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('pasted_otps', _pastedOtps.toList());

      setState(() {
        _clipboardOtp = null;
      });
      _otpController.text = otpToPaste;

      // Unfocus to prevent keyboard from popping up
      if (mounted) {
        FocusScope.of(context).unfocus();
      }

      // Clear the clipboard
      await Clipboard.setData(const ClipboardData(text: ''));
    }
  }

  void _verifyOtp() {
    if (_otpController.text.length == 4) {
      final controller = Get.find<AuthController>();
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
                /// ðŸ”¹ HEADER / BACK BUTTON
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

                        /// ðŸ”¹ Title
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

                        /// ðŸ”¹ Subtitle
                        Text(
                          "Please paste the verification code\nsent to your phone number",
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

                        /// ðŸ”¹ OTP FIELD (Pinput)
                        Pinput(
                          length: 4,
                          autofocus: false,
                          readOnly: true,
                          controller: _otpController,
                          keyboardType: TextInputType.number,
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

                        // Dynamic Paste OTP Button
                        if (_clipboardOtp != null) ...[
                          GestureDetector(
                            onTap: _onPasteOtp,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.clrPrimary.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.clrPrimary,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.paste,
                                    size: 16.sp,
                                    color: AppColors.clrPrimary,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Paste '$_clipboardOtp'",
                                    style: TextStyle(
                                      color: AppColors.clrPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],

                        /// 🔹 Timer
                        ResendTimerWidget(
                          onResend: () {
                            final controller = Get.find<AuthController>();
                            controller.resendOtp();
                          },
                        ),
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

class ResendTimerWidget extends StatefulWidget {
  final VoidCallback onResend;

  const ResendTimerWidget({super.key, required this.onResend});

  @override
  State<ResendTimerWidget> createState() => _ResendTimerWidgetState();
}

class _ResendTimerWidgetState extends State<ResendTimerWidget> {
  Timer? _timer;
  int _start = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    if (!mounted) return;
    setState(() {
      _start = 30;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        if (mounted) {
          setState(() {
            _canResend = true;
          });
        }
        timer.cancel();
      } else {
        if (mounted) {
          setState(() {
            _start--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    if (_canResend) {
      return GestureDetector(
        onTap: () {
          widget.onResend();
          _startTimer();
        },
        child: Text(
          'Resend code',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: isTablet ? 16.sp : 14.sp,
            color:
                AppColors.clrPrimary, // primary color indicating active state
          ),
        ),
      );
    }

    return Text(
      'Resend code in 00:${_start.toString().padLeft(2, '0')}',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: isTablet ? 16.sp : 14.sp,
        color: AppColors.green, // grey color indicating disabled state
      ),
    );
  }
}
