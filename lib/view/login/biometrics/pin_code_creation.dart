import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/view/login/widgets/custom_numeric_keyboard.dart';
import 'package:pinput/pinput.dart';

class PinCodeCreationPage extends GetView<AuthController> {
  PinCodeCreationPage({super.key});

  final TextEditingController pinController =
      TextEditingController();

  final RxBool showAddButton = false.obs;

  void handleKeyPress(String key) {

    if (key == 'backspace') {

      if (pinController.text.isNotEmpty) {

        pinController.text = pinController.text.substring(
          0,
          pinController.text.length - 1,
        );
      }

    } else {

      if (pinController.text.length < 4) {

        pinController.text += key;
      }
    }

    showAddButton.value =
        pinController.text.length == 4;
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
          onPressed: () => Get.back(),

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
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                SizedBox(
                  height: isTablet ? 40.h : 20.h,
                ),

                Text(
                  'Create your Pin code',

                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize:
                        isTablet ? 32.sp : 24.sp,
                    color: colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 40.h),

                /// PIN INPUT
                Center(
                  child: Pinput(

                    length: 4,
                    controller: pinController,
                    readOnly: true,

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    defaultPinTheme: PinTheme(

                      width:
                          isTablet ? 70.w : 56.w,

                      height:
                          isTablet ? 70.w : 56.w,

                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize:
                            isTablet ? 28.sp : 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),

                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,

                        borderRadius:
                            BorderRadius.circular(10.r),
                      ),
                    ),

                    focusedPinTheme: PinTheme(

                      width:
                          isTablet ? 70.w : 56.w,

                      height:
                          isTablet ? 70.w : 56.w,

                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize:
                            isTablet ? 28.sp : 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),

                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,

                        borderRadius:
                            BorderRadius.circular(10.r),

                        border: Border.all(
                          color: colorScheme.onSurface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                /// BUTTON / KEYBOARD
                Obx(
                  () => AnimatedSwitcher(

                    duration:
                        const Duration(milliseconds: 300),

                    child: showAddButton.value

                        ? Row(
                            key: const ValueKey(
                              'action_buttons',
                            ),

                            children: [

                              Expanded(
                                child: SafeArea(
                                  child: TextButton(

                                    onPressed: () {
                                      Get.back();
                                    },

                                    child: Text(
                                      'Cancel',

                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight:
                                            FontWeight.w700,
                                        fontSize: 16.sp,
                                        color: colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 20.w),

                              Expanded(
                                child: CommonButton(

                                  title: "Add",

                                  onTap: () {

                                    controller.createPin(
                                      pinController.text.trim(),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )

                        : Padding(

                            key: const ValueKey(
                              'keyboard',
                            ),

                            padding: EdgeInsets.only(
                              bottom: 20.h,
                            ),

                            child: CustomNumericKeyboard(

                              onKeyPressed:
                                  handleKeyPress,
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