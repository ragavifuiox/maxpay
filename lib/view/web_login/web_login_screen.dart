import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WebLoginScreen extends StatelessWidget {
  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Web Signup"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Email
            TextField(
              decoration: InputDecoration(
                hintText: "Sample@gmail.com",hintStyle: TextHelper.max8,
                filled: true,
                fillColor: const Color(0xfff2f3ff),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter Password",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// Re-enter Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Re-enter Password",
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
  Get.toNamed(AppRoutes.webotp);
  },
),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
