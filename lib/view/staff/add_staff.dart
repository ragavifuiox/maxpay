import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/staff/widget/staff_textfield_widget.dart';


class AddStaffPage extends StatelessWidget {
  const AddStaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Add Staff",
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),

            Text(
              "RegMob No",
              style:TextHelper.max17(context)
            ),

            SizedBox(height: 10.h),

            const StaffTextFieldWidget(
              hintText: "Enter Mobile No",
            ),

            SizedBox(height: 22.h),

            Text(
              "Name",
              style: TextHelper.max17(context),
            ),

            SizedBox(height: 10.h),

            const StaffTextFieldWidget(
              hintText: "William Shakespeare",
            ),

            SizedBox(height: 22.h),

            Text(
              "User ID",
              style: TextHelper.max17(context),
            ),

            SizedBox(height: 10.h),

            const StaffTextFieldWidget(
              hintText: "PL0011AD",
            ),

            const Spacer(),

            Center(
              child: CommonButton(
                title: "Submit",
                onTap: () {
                 Get.to(AppRoutes.setting);
                },
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}