import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController pinController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController wpcontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomePageController>().fetchpopupmessage("Profile");
    });
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        centerTitle: false,

        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.scaffoldBackgroundColor,

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          Obx(() {
            final profile = controller.profileData.value?.data;
            final isActive = (profile?.status ?? "Active") == "Active";

            return Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isActive ? "Active" : "Inactive",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profileData.value?.data;

        /// SET DATA
        nameController.text = profile?.name ?? "";

        pinController.text = profile?.pincode ?? "";

        emailController.text = profile?.email ?? "";

        phoneController.text = profile?.phoneNumber ?? "";

        wpcontroller.text = profile?.whatsappnumber ?? "";
        addresscontroller.text = profile?.address ?? "";

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: ListView(
              children: [
                const SizedBox(height: 20),

                /// PROFILE IMAGE
                Center(
                  child: Stack(
                    children: [
                      Obx(() {
                        final profile = controller.profileData.value?.data;

                        ImageProvider provider;

                        if (controller.selectedImage.value != null) {
                          provider = FileImage(controller.selectedImage.value!);
                        } else if ((profile?.profileimg ?? "").isNotEmpty) {
                          provider = CachedNetworkImageProvider(
                            profile!.profileimg!,
                          );
                        } else {
                          provider = const AssetImage(AssetImages.profileImage);
                        }

                        return CircleAvatar(
                          radius: 48,
                          backgroundImage: provider,
                        );
                      }),

                      Positioned(
                        bottom: 0,
                        right: 0,

                        child: Container(
                          width: 28,
                          height: 28,

                          decoration: BoxDecoration(
                            color: AppColors.clrPrimary,

                            shape: BoxShape.circle,

                            border: Border.all(
                              color: theme.colorScheme.surface,
                              width: 2,
                            ),
                          ),

                          child: GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
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
                      style: TextHelper.max3.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),

                      children: [
                        TextSpan(
                          text: "User ID: ${profile?.userId ?? ""}  ",

                          style: TextHelper.max3.copyWith(
                            fontSize: 14.6,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                /// USER TYPE (separate line, centered, to match screenshot)
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "User Type: ",

                          style: TextHelper.max4.copyWith(
                            fontSize: 14.6,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),

                        TextSpan(
                          text: profile?.usertype ?? "",

                          style: TextHelper.max5.copyWith(
                            fontSize: 14.6,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                /// NAME
                _buildTitle(context, "Name"),

                const SizedBox(height: 8),

                _buildTextField(context, nameController),

                const SizedBox(height: 18),

                /// ADDRESS
                _buildTitle(context, "Address"),

                const SizedBox(height: 8),

                _buildTextField(context, addresscontroller, maxLines: 2),

                const SizedBox(height: 18),

                /// PINCODE
                _buildTitle(context, "Pin code"),

                const SizedBox(height: 8),

                _buildTextField(context, pinController),

                const SizedBox(height: 18),

                /// EMAIL
                _buildTitle(context, "Mail ID"),

                const SizedBox(height: 8),

                _buildTextField(context, emailController),

                const SizedBox(height: 18),

                /// PHONE
                _buildTitle(context, "Reg.Mob No"),

                const SizedBox(height: 8),

                _buildTextField(context, phoneController),

                const SizedBox(height: 18),

                /// WHATSAPP
                _buildTitle(context, "WhatsApp Number"),

                const SizedBox(height: 8),

                _buildTextField(context, wpcontroller),

                const SizedBox(height: 35),

                CommonButton(
                  title: "Update",
                  onTap: () {
                    print("Button Pressed");
                    print("Mobile Value = ${phoneController.text}");
                    print("Mobile Length = ${phoneController.text.length}");
                    print("NAME = ${nameController.text}");
                    print("PINCODE = ${pinController.text}");
                    print(
                      "profileimage😊 = ${controller.selectedImage.value?.path}",
                    );

                    controller.updateProfile(
                      name: nameController.text,
                      email: emailController.text,
                      mobile: phoneController.text,
                      pincode: pinController.text,
                      profileImage: controller.selectedImage.value,
                      address: addresscontroller.text,
                      whatsappnumber: wpcontroller.text,
                    );
                  },
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        title,

        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: theme.colorScheme.onSurface,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,

      enabled: true,

      maxLines: maxLines,

      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: theme.colorScheme.onSurface,
      ),

      decoration: InputDecoration(
        filled: true,

        fillColor: theme.brightness == Brightness.light
            ? AppColors.background
            : theme.colorScheme.surfaceContainer,

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: BorderSide(color: AppColors.border),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: BorderSide(color: AppColors.border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
