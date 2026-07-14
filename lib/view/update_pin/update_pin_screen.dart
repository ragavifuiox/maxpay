import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/update_pin_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/widget/pin_textfield_widget.dart';

class UpdatePinPage extends StatelessWidget {
  UpdatePinPage({super.key});

  final UpdatePinController controller = Get.put(
    UpdatePinController(updatepinusecase: sl(), updateSendOtpUsecase: sl(), updateotpusecase: sl()),
  );

  final TextEditingController newPinController = TextEditingController();

  final TextEditingController confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Update Pin"),
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
                        crossAxisAlignment: .start,
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
                        "New PIN",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      PinTextFieldWidget(
                        hintText: "Enter 4-digit PIN",
                        controller: newPinController,
                      ),

                      SizedBox(height: 24.h),

                      Text(
                        "Confirm PIN",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      PinTextFieldWidget(
                        hintText: "Confirm 4-digit PIN",
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
                              if (newPinController.text.length != 4) {
                                CustomToast.error("Enter valid 4 digit pin");
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
