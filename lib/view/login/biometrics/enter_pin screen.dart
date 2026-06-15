import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/view/login/widgets/custom_numeric_keyboard.dart';
import 'package:pinput/pinput.dart';

class PinCodeEnterPage extends StatefulWidget {
  const PinCodeEnterPage({super.key});
 @override
  State<PinCodeEnterPage> createState() => _PinCodeEnterPageState();
}

class _PinCodeEnterPageState extends State<PinCodeEnterPage> {
  final AuthController controller = Get.find<AuthController>();

  final TextEditingController pinController = TextEditingController();

  final RxBool showVerifyButton = false.obs;
@override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    if (controller.isFingerPrint.value == 1) {
      await controller.authenticateWithFingerprint();
    }
  });
}

void handleKeyPress(String key) {
  String current = pinController.text;

  if (key == 'backspace') {
    if (current.isNotEmpty) {
      current = current.substring(0, current.length - 1);
    }
  } else {
    if (current.length < 4) {
      current = current + key;
    }
  }

  pinController.value = TextEditingValue(
    text: current,
    selection: TextSelection.collapsed(offset: current.length),
  );
  showVerifyButton.value = current.length == 4;
}

  void resetPin() {
    pinController.clear();
    showVerifyButton.value = false;
    setState(() {});
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
  onPressed: () {
    if (showVerifyButton.value) {
      resetPin();
    } else {
      Get.offAllNamed(AppRoutes.loginPhoneName);
    }
  },
  icon: Icon(
    Icons.arrow_back_ios_new,
    color: colorScheme.onSurface,
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
                  'Enter your Pin code',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? 32.sp : 24.sp,
                    color: colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 40.h),

                Center(
                  child: Pinput(
                    length: 4,
                    controller: pinController,
                    readOnly: true,
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
                  ),
                ),

                SizedBox(height: 25.h),

                /// Fingerprint Icon
                Obx(() {
  if (controller.isFingerPrint.value == 1) {
    return const SizedBox(); // Hide icon
  }

  return Align(
    alignment: Alignment.centerRight,
    child: GestureDetector(
      onTap: () async {
        Get.toNamed(AppRoutes.biometricsScanning);
      },
      child: Center(
        child: Icon(
          Icons.fingerprint,
          size: 50.sp,
          color: AppColors.clrPrimary,
        ),
      ),
    ),
  );
}),

                const Spacer(),

                Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: showVerifyButton.value
                        ? Row(
                            key: const ValueKey('verify'),
                            children: [

                              // Expanded(
                              //   child: SafeArea(
                              //     child: TextButton(
                              //       onPressed: () {
                              //         Get.back();
                              //       },
                              //       child: Text(
                              //         'Cancel',
                              //         style: TextStyle(
                              //           fontFamily: 'Poppins',
                              //           fontWeight: FontWeight.w700,
                              //           fontSize: 16.sp,
                              //           color: colorScheme.onSurface,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                                      
                              SizedBox(width: 20.w),
                              Expanded(
                                child: CommonButton(
                                  title: "Verify",
                                  onTap: () async {
                                    final success =
                                        await controller.VerifyPin(
                                      pinController.text.trim(),
                                    );

                                    if (!success) {
                                      resetPin(); // 🔥 IMPORTANT FIX
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            key: const ValueKey('keyboard'),
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: CustomNumericKeyboard(
                              onKeyPressed: handleKeyPress,
                            ),
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