import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/login/widgets/custom_numeric_keyboard.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:pinput/pinput.dart';

class PinCodeCreationPage extends StatefulWidget {
  const PinCodeCreationPage({super.key});

  @override
  State<PinCodeCreationPage> createState() => _PinCodeCreationPageState();
}

class _PinCodeCreationPageState extends State<PinCodeCreationPage> {
  final TextEditingController _pinController = TextEditingController();
  bool _showAddButton = false;

  void _handleKeyPress(String key) {
    setState(() {
      if (key == 'backspace') {
        if (_pinController.text.isNotEmpty) {
          _pinController.text = _pinController.text.substring(
            0,
            _pinController.text.length - 1,
          );
        }
      } else if (key == 'submit') {
        if (_pinController.text.length == 4) {
          context.push(AppRoutes.successScreen);
        }
      } else {
        if (_pinController.text.length < 4) {
          _pinController.text += key;
        }
      }
      _showAddButton = _pinController.text.length == 4;
    });
  }

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
        leading: IconButton(
          onPressed: () => navigator?.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: colorScheme.onSurface,
            size: 20.sp,
          ),
        ),
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
                SizedBox(height: isTablet ? 40.h : 20.h),
                Text(
                  'Create your Pin code',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? 32.sp : 24.sp,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 40.h),

                /// 🔹 PIN INPUT (Pinput)
                Center(
                  child: Pinput(
                    length: 4,
                    controller: _pinController,
                    readOnly: true,
                    mainAxisAlignment: MainAxisAlignment.center,
                    defaultPinTheme: PinTheme(
                      width: isTablet ? 70.w : 56.w,
                      height: isTablet ? 70.w : 56.w,
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: isTablet ? 28.sp : 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: isTablet ? 70.w : 56.w,
                      height: isTablet ? 70.w : 56.w,
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: isTablet ? 28.sp : 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: colorScheme.onSurface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                /// 🔹 ACTION BUTTONS / KEYBOARD
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _showAddButton
                      ? Row(
                          key: const ValueKey('action_buttons'),
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => navigator?.pop(),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: CustomElevatedButton(
                                text: 'Add',
                                height: isTablet ? 70.h : 50.h,
                                onPressed: () {
                                  Get.toNamed(AppRoutes.successScreen);
                                },
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          key: const ValueKey('keyboard'),
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CustomNumericKeyboard(
                            onKeyPressed: _handleKeyPress,
                          ),
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
