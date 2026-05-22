import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/staff/add_staff.dart';

import 'package:maxpay/view/staff/widget/staff_card_widget.dart';


class StaffListPage extends StatelessWidget {
  const StaffListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Staff List",
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            /// ADD STAFF BUTTON
            Center(
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const AddStaffPage());
                },
                child: Container(
                  width: 170.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF14B8C8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Add Staff",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            /// STAFF LIST
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const StaffCardWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}