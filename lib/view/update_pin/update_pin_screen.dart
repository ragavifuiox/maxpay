import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/widget/pin_textfield_widget.dart';



class UpdatePinPage extends StatelessWidget {
  const UpdatePinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar:CommonAppBar(title: "Update Pin"),

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
        style: TextHelper.max15(context)
      ),
    ],
  ),
),

            SizedBox(height: 10.h),

            const PinTextFieldWidget(
              hintText: "Enter Pin",
            ),

            SizedBox(height: 24.h),

            Text(
              "Confirm Pin",
              style: TextHelper.max14(context)
            ),

            SizedBox(height: 10.h),

            const PinTextFieldWidget(
              hintText: "Confirm Pin",
            ),

            const Spacer(),

            Center(
              child: CommonButton(
                title: "Submit",
                onTap: () {
                 Get.toNamed(AppRoutes.setting);
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