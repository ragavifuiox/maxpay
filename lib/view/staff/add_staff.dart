import 'package:flutter/material.dart';
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

  final TextEditingController nameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Add Staff",
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: GetBuilder<AddStaffController>(
          builder: (_) {
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
                ),

                SizedBox(height: 22.h),

                Text(
                  "Name",
                  style: TextHelper.max17(context),
                ),

                SizedBox(height: 10.h),

                StaffTextFieldWidget(
                  hintText: "Enter Name",
                  controller: nameController,
                ),

             

               

                const Spacer(),

                Center(
                  child: CommonButton(
                    title: controller.isLoading
                        ? "Loading..."
                        : "Submit",
                    onTap: () {

                      if (mobileController.text.trim().isEmpty) {
                        CustomToast.error(
                          "Enter Mobile Number",
                        );
                        return;
                      }

                      if (nameController.text.trim().isEmpty) {

                       CustomToast.error(
                          "Enter Name",
                        );
                       
                        return;
                      }

                      controller.addstaff(
                        nameController.text.trim(),
                        mobileController.text.trim(),
                      );
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