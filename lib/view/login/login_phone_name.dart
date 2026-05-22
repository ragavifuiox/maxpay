import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/view/login/widgets/login_textfield.dart';

class LoginPhoneNamePage extends GetView<AuthController> {
  const LoginPhoneNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: colorScheme.onSurface,
            size: 20.sp,
          ),
        ),
        title: Text(
          "Login",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: isTablet ? 24.sp : 18.sp,
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: isTablet ? 60.h : 40.h),

              /// PHONE FIELD
              PhoneNumberField(
                controller: controller.phoneController,
              ),

              SizedBox(height: 16.h),

              /// NAME FIELD
              LoginTextField(
                hintText: "Enter Your Name",
                controller: controller.nameController,
              ),

              SizedBox(height: 16.h),

              /// PINCODE FIELD
              LoginTextField(
                hintText: "Enter Pincode",
                keyboardType: TextInputType.number,
                controller: controller.pincodeController,
              ),

              SizedBox(height: 24.h),

              /// TERMS CHECKBOX
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                      width: 24.w,
                      child: Checkbox(
                        value: controller.isAccepted.value,
                        onChanged: (value) {
                          controller.isAccepted.value = value ?? false;
                        },
                        fillColor: WidgetStateProperty.all(Colors.white),
                        checkColor: Colors.black,
                        side: WidgetStateBorderSide.resolveWith((states) {
                          return const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          );
                        }),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: isTablet ? 16.sp : 13.sp,
                            color: colorScheme.onSurface,
                            height: 1.5,
                          ),
                          children: const [
                            TextSpan(
                              text:
                                  'Registration implies acceptance of the ',
                            ),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: AppColors.clrPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy.',
                              style: TextStyle(
                                color: AppColors.clrPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// LOGIN BUTTON
              Center(
                child: Obx(
                  () => CommonButton(
                    title: controller.isLoading.value
                        ? "Loading..."
                        : "Login",
                    onTap: () async {

                      /// TERMS VALIDATION
                      if (!controller.isAccepted.value) {
                        CustomToast.error(
                          "Please accept Terms & Conditions",
                        );
                        return;
                      }

                      /// PHONE VALIDATION
                      if (controller.phoneController.text.trim().isEmpty) {
                        CustomToast.error(
                          "Please enter phone number",
                        );
                        return;
                      }

                      /// NAME VALIDATION
                      if (controller.nameController.text.trim().isEmpty) {
                        CustomToast.error(
                          "Please enter your name",
                        );
                        return;
                      }

                      /// PINCODE VALIDATION
                      if (controller.pincodeController.text.trim().isEmpty) {
                        CustomToast.error(
                          "Please enter pincode",
                        );
                        return;
                      }

                      if (controller.pincodeController.text.trim().length !=
                          6) {
                        CustomToast.error(
                          "Please enter valid 6 digit pincode",
                        );
                        return;
                      }

                      await controller.login();
                    },
                  ),
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

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

  final AuthController authController =
      Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(8.r),
      ),

      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: isTablet ? 10.h : 2.h,
      ),

      child: Row(
        children: [

          /// COUNTRY CODE PICKER
          CountryCodePicker(

           onChanged: (value) {

  authController.countryCode.value =
      value.dialCode?.replaceAll("+", "") ?? "";

  print(
    "Selected Country Code : ${authController.countryCode.value}",
  );
},

            initialSelection: 'IN',

            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,

            textStyle: TextStyle(
              fontFamily: 'Lufga',
              color: theme.colorScheme.onSurface,
              fontSize: isTablet ? 18.sp : 15.sp,
              fontWeight: FontWeight.w500,
            ),

            dialogTextStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),

            searchDecoration: InputDecoration(
              hintText: "Search Country",

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),

          Container(
            height: 28.h,
            width: 1.w,
            color: Colors.grey.shade400,
          ),

          SizedBox(width: 10.w),

          /// PHONE NUMBER FIELD
          Expanded(
            child: TextField(

              controller: widget.controller,
              keyboardType: TextInputType.phone,

              style: TextStyle(
                fontFamily: 'Lufga',
                color: theme.colorScheme.onSurface,
                fontSize: isTablet ? 20.sp : 16.sp,
                fontWeight: FontWeight.w400,
              ),

              decoration: InputDecoration(
                counterText: "",
                hintText: 'Your phone no',

                hintStyle: TextStyle(
                  fontFamily: 'Lufga',
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: isTablet ? 20.sp : 16.sp,
                  fontWeight: FontWeight.w400,
                ),

                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}