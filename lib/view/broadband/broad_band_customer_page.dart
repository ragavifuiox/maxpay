import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/broadband/broad_band_success_page.dart';
import 'package:maxpay/view/fastag_recharge/fastag_success_screen.dart';

class BroadBandCustomerPage extends StatelessWidget {
  const BroadBandCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title:""),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
          child: SizedBox(
            height: 50.h,
            child:  Center(
                child: CommonButton(
                  title: 'Pay Now',
                  onTap:(){

                    Get.to(BroadBandSuccessPage());
                  }
                 
                ),
              ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
            
                child: RotatedBox(
  quarterTurns: 2,
  child: Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: const Color(0xffF5F5FA),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        _row(
          "Product Name",
          CircleAvatar(
            radius: 12.r,
            backgroundColor: Colors.red,
            child: const Text(
              "Jio",
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
        ),
        SizedBox(height: 15.h),

        _row(
          "Payment Status",
          Text(
            "Paid",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),

        SizedBox(height: 15.h),

        _row(
          "Transaction No",
          Text(
            "TXN234322323",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),

        SizedBox(height: 15.h),

        _row(
          "Transaction Amount",
          Text(
            "₹2365.00",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),

        SizedBox(height: 15.h),

        _row(
          "Plan Name",
          Text(
            "Neon Stop Unlimited",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),

        SizedBox(height: 15.h),

        _row(
          "Whatsapp No",
          Text(
            "9865389363",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    ),
  ),
),
              ),

              SizedBox(height: 35.h),

              SizedBox(
                width: 170.w,
                height: 42.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0A2A6A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Please Confirm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

 Widget _row(String title, Widget value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: 130.w,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 13.sp,
          ),
        ),
      ),

      SizedBox(width: 8.w),

      Text(
        ":",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 13.sp,
        ),
      ),

      SizedBox(width: 12.w),

      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: value,
        ),
      ),
    ],
  );
}
}