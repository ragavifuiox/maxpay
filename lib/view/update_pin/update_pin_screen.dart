import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/update_pin_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

import 'package:maxpay/view/update_pin/widget/pin_textfield_widget.dart';

class UpdatePinPage extends StatelessWidget {
  UpdatePinPage({super.key});

  final UpdatePinController controller =
      Get.put(UpdatePinController(updatepinusecase: sl()));

  final TextEditingController newPinController =
      TextEditingController();

  final TextEditingController confirmPinController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar(title: "Update Pin"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),

            RichText(
              text: TextSpan(
                text: "New Pin ",
                style: TextHelper.max14(context),
                children: [
                  TextSpan(
                    text: "(4 digits only)",
                    style: TextHelper.max15(context),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            PinTextFieldWidget(
              hintText: "Enter Pin",
              controller: newPinController,
            ),

            SizedBox(height: 24.h),

            Text(
              "Confirm Pin",
              style: TextHelper.max14(context),
            ),

            SizedBox(height: 10.h),

            PinTextFieldWidget(
              hintText: "Confirm Pin",
              controller: confirmPinController,
            ),

            const Spacer(),

            Obx(
              () => CommonButton(
                title: controller.isLoading.value
                    ? "Loading..."
                    : "Submit",
                onTap: () async {
  if (newPinController.text.length != 4) {
    CustomToast.error("Enter valid 4 digit pin");
    return;
  }

  if (confirmPinController.text.length != 4) {
    CustomToast.error("Enter valid confirm pin");
    return;
  }

  if (newPinController.text != confirmPinController.text) {
    CustomToast.error("Pins do not match");
    return;
  }

  await controller.updatePin(
    newPin: int.parse(newPinController.text),
    confirmPin: int.parse(confirmPinController.text),
  );
},
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}