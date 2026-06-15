import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({super.key});

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController pinController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
  Get.find<HomePageController>().fetchpopupmessage("Profile");
});
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      resizeToAvoidBottomInset: true,

      appBar: const CommonAppBar(
        title: "Profile",
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final profile =
            controller.profileData.value?.data;

        /// SET DATA
        nameController.text =
            profile?.name ?? "";

        pinController.text =
            profile?.pincode ?? "";

        emailController.text =
            profile?.email ?? "";

        phoneController.text =
            profile?.phoneNumber ?? "";

        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            child: ListView(
              children: [
                const SizedBox(height: 20),

                /// PROFILE IMAGE
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 95,
                        height: 95,

                        decoration:
                            const BoxDecoration(
                          shape: BoxShape.circle,

                          image:
                              DecorationImage(
                            image: AssetImage(
                              AssetImages
                                  .profileImage,
                            ),

                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,

                        child: Container(
                          width: 28,
                          height: 28,

                          decoration:
                              BoxDecoration(
                            color: AppColors
                                .clrPrimary,

                            shape:
                                BoxShape.circle,

                            border:
                                Border.all(
                              color: theme
                                  .colorScheme
                                  .surface,
                              width: 2,
                            ),
                          ),

                          child: const Icon(
                            Icons
                                .camera_alt_outlined,
                            color:
                                Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                /// USER INFO
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextHelper.max3
                          .copyWith(
                        color: theme
                            .colorScheme
                            .onSurface,
                      ),

                      children: [
                        TextSpan(
                          text:
                              "User ID: ${profile?.userId ?? ""}  ",

                          style: TextHelper
                              .max3
                              .copyWith(
                            fontSize: 14.6,
                            fontWeight:
                                FontWeight
                                    .bold,
                            color: theme
                                .colorScheme
                                .onSurface,
                          ),
                        ),

                        TextSpan(
                          text: "Status: ",

                          style: TextHelper
                              .max4
                              .copyWith(
                            fontSize: 14.6,
                            color: theme
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),

                        TextSpan(
                          text:
                              profile?.status ??
                                  "",

                          style: TextHelper
                              .max5
                              .copyWith(
                            fontSize: 14.6,
                            color: theme
                                .colorScheme
                                .primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                /// NAME
                _buildTitle(
                  context,
                  "Name",
                ),

                const SizedBox(height: 8),

                _buildTextField(
                  context,
                  nameController,
                ),

                const SizedBox(height: 18),

                /// PINCODE
                _buildTitle(
                  context,
                  "Pin code",
                ),

                const SizedBox(height: 8),

                _buildTextField(
                  context,
                  pinController,
                ),

                const SizedBox(height: 18),

                /// EMAIL
                _buildTitle(
                  context,
                  "Mail ID",
                ),

                const SizedBox(height: 8),

                _buildTextField(
                  context,
                  emailController,
                ),

                const SizedBox(height: 18),

                /// PHONE
                _buildTitle(
                  context,
                  "Phone no",
                ),

                const SizedBox(height: 8),

                _buildTextField(
                  context,
                  phoneController,
                ),

                const SizedBox(height: 35),

                /// UPDATE BUTTON
                CommonButton(
                  title: "Update",

                  onTap: () {},
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTitle(
    BuildContext context,
    String title,
  ) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        title,

        style: TextHelper.max6.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller,
  ) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,

      enabled: false,

      style: TextStyle(
        color: theme.colorScheme.onSurface,
      ),

      decoration: InputDecoration(
        filled: true,

        fillColor:
            theme.brightness ==
                    Brightness.light
                ? const Color(
                    0xffF1F1F1,
                  )
                : theme.colorScheme
                    .surfaceContainer,

        disabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide: BorderSide(
            color:
                theme.colorScheme.outline,
          ),
        ),

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide: BorderSide(
            color:
                theme.colorScheme.outline,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide: BorderSide(
            color:
                theme.colorScheme.outline,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide: BorderSide(
            color:
                theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}