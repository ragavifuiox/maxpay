import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WebSignupScreen extends StatelessWidget {
  const WebSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(

      /// ✅ Dark Theme Support
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Web Signup",
      ),

      body: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 24,
        ),

        child: Column(
          children: [

            const SizedBox(height: 20),

            /// EMAIL
            TextField(

              style: TextStyle(
                color:
                    theme.colorScheme.onSurface,
              ),

              decoration: InputDecoration(

                hintText: "Sample@gmail.com",

                hintStyle: TextHelper.max8.copyWith(
                  color: theme.colorScheme
                      .onSurfaceVariant,
                ),

                filled: true,

                fillColor:
                    theme.brightness ==
                            Brightness.dark
                        ? theme.colorScheme
                            .surfaceContainer
                        : const Color(
                            0xfff2f3ff,
                          ),

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

            const SizedBox(height: 15),

            /// PASSWORD
            TextField(

              obscureText: true,

              style: TextStyle(
                color:
                    theme.colorScheme.onSurface,
              ),

              decoration: InputDecoration(

                hintText: "Enter Password",

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

            const SizedBox(height: 15),

            /// RE-ENTER PASSWORD
            TextField(

              obscureText: true,

              style: TextStyle(
                color:
                    theme.colorScheme.onSurface,
              ),

              decoration: InputDecoration(

                hintText:
                    "Re-enter Password",

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
                  AppRoutes.webotp,
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