
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/download_controller.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/earning_controller.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/controllers/refund_controller.dart';
import 'package:maxpay/controllers/wallet_credit_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/global_widget/commom_button.dart';


class SuccessRechargePage extends StatelessWidget {
  final String productName;
  final String operatorInitial;
  final Color operatorColor;
  final String transactionNo;
  final String rechargeAmount;
  final String transactionId;
  final String dateTime;
  final String operatorLogo; // image URL
  final String rechargeId;
  
  const SuccessRechargePage({
    super.key,
    required this.productName,
    required this.operatorInitial,
    required this.operatorColor,
    required this.transactionNo,
    required this.rechargeAmount,
    required this.transactionId,
    required this.dateTime,
    required this.operatorLogo,
    required this.rechargeId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final ProfileController profileController = Get.put(
      ProfileController(getProfileUseCase: sl(), profileUpdateUseCase: sl(), updateprofileotpusecase: sl()),
    );
final DownloadController downloadController = Get.put(
      DownloadController(downloadUseCase: sl()),
    );
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              /// SUCCESS ICON
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              Text(
                'Recharge Successful !!!',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),

              SizedBox(height: 40.h),

              /// SUMMARY CARD
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkplceholder.withValues(alpha: 0.5)
                      : AppColors.clrplceholder,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow(
                      'Product',
                      '',
                      isIcon: true,
                      imageUrl: operatorLogo,
                      context: context,
                    ),
                    _buildSummaryRow(
                      'Transaction No',
                      transactionNo,
                      context: context,
                    ),
                    _buildSummaryRow(
                      'Recharge Amount',
                      rechargeAmount,
                      context: context,
                    ),
                    _buildSummaryRow(
                      'Transaction ID',
                      transactionId,
                      context: context,
                    ),
                    _buildSummaryRow('Date & Time', dateTime, context: context),

                    SizedBox(height: 10.h),

                    GestureDetector(
                      onTap: () =>
                          _showTransactionDetails(context, profileController),
                      child: Text(
                        'View Detail',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              CommonButton(
                title: "Done",
                onTap: () {
                  try {
                    if (Get.isRegistered<HomePageController>()) {
                      final homeController = Get.find<HomePageController>();
                      homeController.fetchWalletBalance();
                      homeController.getTransactionSummary();
                    }
                    if (Get.isRegistered<EarningController>()) {
                      Get.find<EarningController>().fetchEarnings();
                    }
                    if (Get.isRegistered<WalletCreditController>()) {
                      Get.find<WalletCreditController>().fetchCredit();
                    }
                    // if (Get.isRegistered<TransReportController>()) {
                    //   final reportController =
                    //       Get.find<TransReportController>();
                    //   if (reportController.fromDate.isNotEmpty &&
                    //       reportController.toDate.isNotEmpty) {
                    //     reportController.transactionreport(
                    //       search: reportController.search,
                    //       status: '',
                    //       productid: '',
                    //       fromdate: reportController.fromDate,
                    //       todate: reportController.toDate,
                    //     );
                    //   }
                    // }
                    if (Get.isRegistered<RefundController>()) {
                      final refundController = Get.find<RefundController>();
                      if (refundController.fromDate.isNotEmpty &&
                          refundController.toDate.isNotEmpty) {
                        refundController.getPaymentStatus();
                      }
                    }
                  } catch (e) {
                    debugPrint("Error updating state: $e");
                  }
Get.offAllNamed(AppRoutes.main);                },
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- DETAILS POPUP ----------------

  void _showTransactionDetails(
  BuildContext context,
  ProfileController profileController,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  final profile = profileController.profileData.value?.data;

  final DownloadController downloadController = Get.put(
    DownloadController(downloadUseCase: sl()),
  );

  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: 340.w,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkplceholder : Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Text(
                      "Transaction Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Transaction ID : $transactionId",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),

                SizedBox(height: 5.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date & Time : $dateTime",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),

                SizedBox(height: 12.h),

                Divider(),

                _detailRow(
                  context,
                  "Transaction",
                  "Success",
                  valueColor: Colors.green,
                ),

                _detailRow(
                  context,
                  "Transaction No",
                  transactionNo,
                ),

                _detailRow(
                  context,
                  "Transaction Amount",
                  rechargeAmount.currencyIndian,
                ),

                _detailRow(
                  context,
                  "Product Type",
                  "Mobile Prepaid",
                ),

                _logoRow(
                  "Product",
                  operatorLogo,
                  context,
                ),

                _detailRow(
                  context,
                  "Product Ref Id",
                  transactionId,
                ),

                SizedBox(height: 12.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                      _detailRow(
                        context,
                        "Retailer Name",
                        profile?.name ?? "N/A",
                        textColor: Colors.white,
                      ),
                      _detailRow(
                        context,
                        "Contact No",
                        profile?.phoneNumber ?? "N/A",
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15.h),

                Text(
                  "T & C Apply",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.sp,
                  ),
                ),

                SizedBox(height: 20.h),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 42.h,
                        child: ElevatedButton(
                          onPressed: () {
                            downloadController.downloadReceipt(rechargeId);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Download",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 5.w),
                              Icon(
                                Icons.download,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: SizedBox(
                        height: 42.h,
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            "Ok",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

  Widget _logoRow(String title, String imageUrl, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
            ),
          ),

          Text(":"),

          SizedBox(width: 10.w),

          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.network(
                imageUrl,
                width: 45.w,
                height: 25.h,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) {
                  return Icon(Icons.image_not_supported, size: 18.sp);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  

  String _receiptFileName() {
    final id = rechargeId.isNotEmpty
        ? rechargeId
        : DateTime.now().millisecondsSinceEpoch.toString();
    final safeId = id.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');

    return "Receipt_$safeId.pdf";
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isIcon = false,
    String? imageUrl,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// LEFT LABEL (fixed width = alignment fix)
          SizedBox(
            width: 130.w,
            child: Text(
              label,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey),
            ),
          ),

          /// COLON (fixed position)
          SizedBox(
            width: 15.w,
            child: Text(
              ":",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
          ),

          /// RIGHT VALUE AREA (ALWAYS SAME START POSITION)
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: isIcon
                  ? (imageUrl != null && imageUrl.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Image.network(
                              imageUrl,
                              width: 45.w,
                              height: 25.h,
                              fit: BoxFit.contain,
                            ),
                          )
                        : CircleAvatar(
                            radius: 12.r,
                            backgroundColor: Colors.grey.shade300,
                            child: Text(
                              operatorInitial,
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          )
                  : Text(
                      value,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- DETAIL ROW ----------------

  Widget _detailRow(
  BuildContext context,
  String title,
  String value, {
  Color? valueColor,
  Color? textColor,
}) {
  final color = textColor ??
      (Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black);

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        SizedBox(
          width: 10.w,
          child: Text(
            ":",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: valueColor ?? color,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}}
