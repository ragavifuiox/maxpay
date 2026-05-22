import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class WebLoginScreen extends StatelessWidget {
  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/login_bg.png",
              fit: BoxFit.cover,
            ),
          ),

          /// DARK BLUR OVERLAY
         /// BACKGROUND COLOR
Container(
  width: double.infinity,
  height: double.infinity,
  color: Colors.white,
),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  /// BACK BUTTON + TITLE
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Text(
                        "Scan & Web Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 80.h),

                  /// QR SCANNER BOX
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        /// QR WHITE BOX
                        Container(
                          width: 220.w,
                          height: 220.w,
                          padding: EdgeInsets.all(18.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset(
                            "assets/images/qr_code.png",
                            fit: BoxFit.cover,
                          ),
                        ),

                        /// SCAN LINE
                        Positioned(
                          child: Container(
                            width: 250.w,
                            height: 3.h,
                            color: const Color(0xFF11C5E8),
                          ),
                        ),

                        /// CORNERS
                        SizedBox(
                          width: 280.w,
                          height: 280.w,
                          child: Stack(
                            children: [
                              _corner(top: 0, left: 0),
                              _corner(top: 0, right: 0),
                              _corner(bottom: 0, left: 0),
                              _corner(bottom: 0, right: 0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  /// SUBMIT BUTTON
                  Center(
                    child: CommonButton(
                      title: "Submit",
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _corner({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            top: top != null
                ? const BorderSide(
                    color: Color(0xFF11C5E8),
                    width: 6,
                  )
                : BorderSide.none,
            bottom: bottom != null
                ? const BorderSide(
                    color: Color(0xFF11C5E8),
                    width: 6,
                  )
                : BorderSide.none,
            left: left != null
                ? const BorderSide(
                    color: Color(0xFF11C5E8),
                    width: 6,
                  )
                : BorderSide.none,
            right: right != null
                ? const BorderSide(
                    color: Color(0xFF11C5E8),
                    width: 6,
                  )
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}