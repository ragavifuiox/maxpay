import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WebOtpScreen extends StatelessWidget {
  const WebOtpScreen({super.key});
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "OTP"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text("SMS Otp",style: TextHelper.max6,),
            ),

            const SizedBox(height: 5),

            /// SMS OTP
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Otp",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text("Mail Otp",style: TextHelper.max6,),
            ),

            const SizedBox(height: 5),

            /// Mail OTP
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Otp",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const Spacer(),

            /// Submit Button
                 CommonButton(
  title: "Submit",
 
  onTap: () {
  Get.toNamed(AppRoutes.websuccess);
  },
),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
