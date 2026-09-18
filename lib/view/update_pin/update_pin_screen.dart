import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/update_pin_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/update_pin/widget/pin_textfield_widget.dart';

class UpdatePinPage extends StatelessWidget {
  UpdatePinPage({super.key});

  final UpdatePinController controller = Get.put(
    UpdatePinController(
      updatepinusecase: sl(),
      updateSendOtpUsecase: sl(),
      updateotpusecase: sl(),
    ),
  );

  final TextEditingController oldPinController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Update M Pin"),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter your new 4-digit  MPIN .",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Poppins',
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                          SizedBox(height: 36.h),
                        ],
                      ),

                      Text(
                        "Old M PIN",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      PinTextFieldWidget(
                        hintText: "Enter 4-digit old PIN",
                        controller: oldPinController,
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  title: Text(
                                    'Contact Support',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    'To reset your M PIN, please contact support.',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back(); // close dialog
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            theme.platform == TargetPlatform.iOS
                                            ? AppColors.clrPrimary
                                            : AppColors.clrPrimary, // Using basic primary looking color or you can use AppColors
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.back(); // close dialog
                                        Get.toNamed(
                                          AppRoutes.support,
                                          arguments: {'showBack': true},
                                        ); // move to support
                                      },
                                      child: Text(
                                        'Continue',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Reset M PIN",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      Text(
                        "New M PIN",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      PinTextFieldWidget(
                        hintText: "Enter 4-digit new PIN",
                        controller: newPinController,
                      ),

                      SizedBox(height: 24.h),

                      Text(
                        "Confirm M PIN",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      PinTextFieldWidget(
                        hintText: "Confirm 4-digit M PIN",
                        controller: confirmPinController,
                      ),

                      const Spacer(),

                      SizedBox(height: 30.h),

                      Obx(
                        () => Center(
                          child: CommonButton(
                            title: "Submit",
                            isLoading: controller.isLoading.value,
                            onTap: () async {
                              if (oldPinController.text.length != 4) {
                                CustomToast.error("Enter valid old pin");
                                return;
                              }

                              if (newPinController.text.length != 4) {
                                CustomToast.error("Enter valid new pin");
                                return;
                              }

                              if (confirmPinController.text.length != 4) {
                                CustomToast.error("Enter valid confirm pin");
                                return;
                              }

                              if (newPinController.text !=
                                  confirmPinController.text) {
                                CustomToast.error("Pins do not match");
                                return;
                              }

                              await controller.updatePin(
                                oldpin: int.parse(oldPinController.text),
                                newPin: int.parse(newPinController.text),
                                confirmPin: int.parse(
                                  confirmPinController.text,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
