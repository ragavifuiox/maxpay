import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/web_login_controller.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class WebLoginScreen extends GetView<WebLoginController> {
  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            // child: Image.asset(
            //   "assets/images/login_bg.png",
            //   fit: BoxFit.cover,
            // ),
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),

                  /// HEADER
                  Row(
                    children: [
                      GestureDetector(
                        onTap: Get.back,
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
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 80.h),

                  /// SCANNER
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 220.w,
                          height: 220.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child:MobileScanner(
  onDetect: (capture) {
    if (controller.isScanned.value) return;

    final barcode = capture.barcodes.first.rawValue;

    if (barcode != null && barcode.isNotEmpty) {
      controller.scannedUserId.value = barcode;
      controller.isScanned.value = true;

      Get.snackbar(
        "Success",
        "QR Scanned Successfully",
      );
    }
  },
),
                          ),
                        ),

                        /// SCAN LINE
                        // Positioned(
                        //   child: Container(
                        //     width: 250.w,
                        //     height: 3.h,
                        //     color: const Color(0xFF11C5E8),
                        //   ),
                        // ),

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

                  SizedBox(height: 20.h),

                  /// SCANNED VALUE
                  Obx(
                    () => Text(
                      controller.scannedUserId.value.isEmpty
                          ? "Scan QR Code"
                          : controller.scannedUserId.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const Spacer(),

                  /// SUBMIT BUTTON
                  Obx(
                    () => CommonButton(
                      title: controller.isLoading.value
                          ? "Loading..."
                          : "Submit",
                      onTap: controller.isLoading.value
                          ? null
                          : () {
                              if (controller
                                  .scannedUserId.value.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Please scan QR code first",
                                );
                                return;
                              }

                              controller.submitLogin();
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