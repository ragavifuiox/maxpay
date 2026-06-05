import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class LoginPhoneNamePage extends GetView<AuthController> {
  const LoginPhoneNamePage({super.key});

@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  return Scaffold(
    backgroundColor: theme.scaffoldBackgroundColor,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              SizedBox(height: 120.h),

              /// LOGO
              Center(
                child: SvgPicture.asset(
                  isDark
                      ? AssetImages.splashLogoDark
                      : AssetImages.splashLogo,
                  height: 190.h,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 80.h),

              /// PHONE FIELD
              PhoneNumberField(
                controller: controller.phoneController,
              ),

              SizedBox(height: 18.h),

              /// TERMS
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Checkbox(
                        value: controller.isAccepted.value,
                        onChanged: (value) {
                          controller.isAccepted.value =
                              value ?? false;
                        },
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),

                    SizedBox(width: 8.w),

                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: 11.sp,
                            height: 1.5,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                          children: const [
                            TextSpan(
                              text:
                                  "Registration implies acceptance of the ",
                            ),
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(
                                color: AppColors.clrPrimary,
                              ),
                            ),
                            TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy.",
                              style: TextStyle(
                                color: AppColors.clrPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 47.h),

              /// SUBMIT BUTTON
              SizedBox(
                width: 222.w,
                height: 50.h,
                child: Obx(
                  () => CommonButton(
                    title: controller.isLoading.value
                        ? "Loading..."
                        : "Submit",
                    onTap: () {
  if (!controller.isAccepted.value) {
    CustomToast.error(
      "Please accept Terms & Conditions",
    );
    return;
  }

  if (controller.phoneController.text.trim().isEmpty) {
    CustomToast.error(
      "Please enter phone number",
    );
    return;
  }

  if (controller.phoneController.text.trim().length < 10) {
    CustomToast.error(
      "Please enter valid mobile number",
    );
    return;
  }

  controller.login();
},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}}

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;

  const PhoneNumberField({
    super.key,
    required this.controller,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      height:50.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Row(
        children: [
          CountryCodePicker(
            initialSelection: 'IN',
            favorite: const ['+91'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            onChanged: (value) {
              authController.countryCode.value =
                  value.dialCode?.replaceAll("+", "") ?? "";
            },
          ),

          Container(
            height: 21.h,
            width: 1,
            color: Colors.grey.shade400,
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              style: TextStyle(
                fontSize: isTablet ? 8.sp : 13.sp,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "",
                hintText: "Enter mobile number",
              ),
            ),
          ),
        ],
      ),
    );
  }
}