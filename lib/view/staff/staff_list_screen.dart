import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_staff_controller.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/custom_app.dart';

import 'package:maxpay/view/staff/widget/staff_card_widget.dart';


class StaffListPage extends StatelessWidget {
  const StaffListPage({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AddStaffController>(
     
      builder: (controller) { 

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
                   onTap: () async {
  final result = await Get.toNamed(AppRoutes.addstaff);

  if (result == true) {
    controller.stafflist();
  }
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

                Expanded(
                  child: controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: controller.staff.length,
                          itemBuilder: (context, index) {

                            final item = controller.staff[index];

                            return StaffCardWidget(
                              data: item,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}