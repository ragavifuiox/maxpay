import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/injection_container.dart';
import 'package:maxpay/controllers/profile/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      ProfileController(getProfileUseCase: sl(), profileUpdateUseCase: sl()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CommonAppBar(title: "Profile"),
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            20,
            0,
            20,
            MediaQuery.viewInsetsOf(context).bottom + 25,
          ),
          child: Obx(() {
            return Column(
              children: [
                const SizedBox(height: 10),

                /// PROFILE IMAGE
                Stack(
                  children: [
                    Container(
                      width: 95,
                      height: 95,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              controller.profileData.value?.data?.profileimg ?? "https://i.pravatar.cc/300"),
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
                        decoration: BoxDecoration(
                          color: AppColors.clrPrimary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.surface,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                /// NAME
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: TextHelper.max6.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(context, controller.nameController, "Enter Name"),
                const SizedBox(height: 18),

                /// EMAIL
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email ID",
                    style: TextHelper.max6.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(context, controller.emailController, "Enter Email ID"),
                const SizedBox(height: 18),

                /// WHATSAPP NUMBER
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "WhatsApp Number",
                    style: TextHelper.max6.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(context, controller.whatsappController, "Enter WhatsApp Number"),
                const SizedBox(height: 18),

                /// BILLING ADDRESS
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Billing Address",
                    style: TextHelper.max6.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(context, controller.addressController, "Enter Billing Address"),
                const SizedBox(height: 18),

                /// PINCODE
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pin code",
                    style: TextHelper.max6.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(context, controller.pincodeController, "Enter Pin code"),
                const SizedBox(height: 40),

                /// UPDATE BUTTON
                CommonButton(
                  title: "Update",
                  isLoading: controller.isUpdateLoading.value,
                  onTap: () {
                    if (!controller.isUpdateLoading.value) {
                      controller.updateProfile();
                    }
                  },
                ),
                const SizedBox(height: 25),
              ],
            );
          }),
        ),
      ),
    );
  }

  static Widget _buildTextField(BuildContext context, TextEditingController controller, String hint) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
        filled: true,
        fillColor: theme.brightness == Brightness.light
            ? AppColors.border
            : theme.colorScheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.darktextclr.withValues(alpha: 0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.darktextclr.withValues(alpha: 0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
    );
  }
}
