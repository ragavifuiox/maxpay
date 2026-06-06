import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/core/constants/colors.dart';

class PdfScreen extends StatelessWidget {
  final String transactionId;
  final String dateTime;
  final String transactionNo;
  final String rechargeAmount;
  final String operatorLogo;

  final ProfileController profileController;

  const PdfScreen({
    super.key,
    required this.transactionId,
    required this.dateTime,
    required this.transactionNo,
    required this.rechargeAmount,
    required this.operatorLogo,
    required this.profileController,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profile = profileController.profileData.value?.data;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkplceholder : Colors.white,
      appBar: AppBar(
        title: const Text("Transaction Details"),
        backgroundColor: AppColors.clrPrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Transaction ID : $transactionId",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.totalborder1,
              ),
            ),

            SizedBox(height: 4.h),

            Text(
              "Date & Time : $dateTime",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.totalborder1,
              ),
            ),

            SizedBox(height: 12.h),

            const Divider(),

            _detailRow(context, "Transaction", "Success",
                valueColor: Colors.green),

            _detailRow(context, "Transaction No", transactionNo),

            _detailRow(context, "Transaction Amount", rechargeAmount),

            _detailRow(context, "Product Type", "Mobile Prepaid"),

            _logoRow("Product", operatorLogo, context),

            _detailRow(context, "Product Ref Id", transactionId),

            SizedBox(height: 10.h),

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
                  ),
                  _detailRow(
                    context,
                    "Contact No",
                    profile?.phoneNumber ?? "N/A",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
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

   Widget _detailRow(
  BuildContext context,
  String title,
  String value, {
  Color? valueColor,
  Color? textColor,

}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      children: [
        Expanded(
          flex: 4,
          child:
          Text(
  title,
  style: TextStyle(
    color: textColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87),
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
  ),
),
        ),
        Text(
          ":",
          style: TextStyle(
            color: textColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87),
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          flex: 5,
          child: Text(
  value,
  textAlign: TextAlign.end,
  style: TextStyle(
    color: valueColor ??
        textColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black),
    fontWeight: FontWeight.w700,
    fontSize: 13.sp,
  ),
),
        ),
      ],
    ),
  );
}
}