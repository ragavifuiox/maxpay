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

    final theme = Theme.of(context);

    return Scaffold(

      /// ✅ Dark Theme Support
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "OTP",
      ),

      body: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 24,
        ),

        child: Column(
          children: [

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,

              child: Text(
                "SMS Otp",

                style:
                    TextHelper.max6.copyWith(
                  color: theme
                      .colorScheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: 5),

            /// SMS OTP
            TextField(

              style: TextStyle(
                color:
                    theme.colorScheme.onSurface,
              ),

              decoration: InputDecoration(

                hintText: "Enter Otp",

                hintStyle: TextStyle(
                  color: theme.colorScheme
                      .onSurfaceVariant,
                ),

                filled: true,

                fillColor:
                    theme.brightness ==
                            Brightness.dark
                        ? theme.colorScheme
                            .surfaceContainer
                        : Colors.grey.shade100,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    8,
                  ),

                  borderSide:
                      BorderSide.none,
                ),

                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    8,
                  ),

                  borderSide: BorderSide(
                    color: theme
                        .colorScheme
                        .outline,
                  ),
                ),

                focusedBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    8,
                  ),

                  borderSide: BorderSide(
                    color: theme
                        .colorScheme
                        .primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,

              child: Text(
                "Mail Otp",

                style:
                    TextHelper.max6.copyWith(
                  color: theme
                      .colorScheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: 5),

            /// MAIL OTP
            TextField(

              style: TextStyle(
                color:
                    theme.colorScheme.onSurface,
              ),

              decoration: InputDecoration(

                hintText: "Enter Otp",

                hintStyle: TextStyle(
                  color: theme.colorScheme
                      .onSurfaceVariant,
                ),

                filled: true,

                fillColor:
                    theme.brightness ==
                            Brightness.dark
                        ? theme.colorScheme
                            .surfaceContainer
                        : Colors.grey.shade100,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    8,
                  ),

                  borderSide:
                      BorderSide.none,
                ),

                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    8,
                  ),

                  borderSide: BorderSide(
                    color: theme
                        .colorScheme
                        .outline,
                  ),
                ),

                focusedBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    8,
                  ),

                  borderSide: BorderSide(
                    color: theme
                        .colorScheme
                        .primary,
                  ),
                ),
              ),
            ),

            const Spacer(),

            /// SUBMIT BUTTON
            CommonButton(
              title: "Submit",

              onTap: () {
                Get.toNamed(
                  AppRoutes.websuccess,
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}