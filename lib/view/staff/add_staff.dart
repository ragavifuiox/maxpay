import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_staff_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/staff/widget/staff_textfield_widget.dart';

class AddStaffPage extends GetView<AddStaffController> {
  AddStaffPage({super.key});

  final TextEditingController mobileController =
      TextEditingController();
final TextEditingController packageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Add Staff"),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: GetBuilder<AddStaffController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),

                Text(
                  "RegMob No",
                  style: TextHelper.max17(context),
                ),

                SizedBox(height: 10.h),

                StaffTextFieldWidget(
                  hintText: "Enter Mobile No",
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) {
                    if (value.length == 10) {
                      controller.searchStaff(value);
                    } else {
                      controller.nameController.clear();
                    }
                  },
                ),

                SizedBox(height: 22.h),

                Text(
                  "Name",
                  style: TextHelper.max17(context),
                ),

                SizedBox(height: 10.h),

                StaffTextFieldWidget(
                  hintText: "Staff Name",
                  controller: controller.nameController,
                ),
                
SizedBox(height: 22.h),

Text(
  "Package",
  style: TextHelper.max17(context),
),

SizedBox(height: 10.h),

StaffTextFieldWidget(
  hintText: "Package",
  controller: controller.packageController,
),
                const Spacer(),

                Center(
                  child: CommonButton(
                    title: controller.isLoading
                        ? "Loading..."
                        : "Submit",
                    onTap: () {
                      final mobile =
                          mobileController.text.trim();

                      final name =
                          controller.nameController.text.trim();
                      final package = controller.packageController.text.trim();

                      if (mobile.isEmpty) {
                        CustomToast.error(
                          "Enter Mobile Number",
                        );
                        return;
                      }

                      if (mobile.length != 10) {
                        CustomToast.error(
                          "Please enter 10 digit number",
                        );
                        return;
                      }

                      if (name.isEmpty) {
                        CustomToast.error("Enter Name");
                        return;
                      }

                      controller.addstaff(name, mobile, package);
                    },
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            );
          },
        ),
      ),
    );
  }
}