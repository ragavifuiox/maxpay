import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WebSignupSuccessScreen extends StatelessWidget {
  const WebSignupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      /// ✅ Dark Theme Support
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: ""),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            children: [
              const SizedBox(height: 60),

              /// SUCCESS TITLE
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      "Success",

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,

                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// IMAGE
              Image.asset(AssetImages.websuccess, height: 220),

              const SizedBox(height: 30),

              /// MESSAGE
              Text(
                "Your web link has been sent to your\nmail id please check your inbox.",

                textAlign: TextAlign.center,

                style: TextStyle(
                  color: theme.brightness == Brightness.dark
                      ? Colors.greenAccent
                      : Colors.green,

                  fontSize: 14,
                ),
              ),

              const Spacer(),

              /// BUTTON
              Center(
                child: CommonButton(
                  title: "Submit",

                  onTap: () {
                    Get.offAllNamed(AppRoutes.main);
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
