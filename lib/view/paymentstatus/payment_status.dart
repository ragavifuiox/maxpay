import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/paymentstatus/widget/search_filter_.dart';


import 'package:get/get.dart';
import 'package:maxpay/controllers/payment_status_controller.dart';

class PaymentStatusScreen extends GetView<PaymentStatusController> {
  const PaymentStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: "Payment Status",
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            const PaymentFilterBox(),

            SizedBox(height: 16.h),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.paymentstatus.isEmpty) {
                  return const Center(
                    child: Text("No Data Found"),
                  );
                }

                return ListView.separated(
                  itemCount:
                      controller.paymentstatus.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item =
                        controller.paymentstatus[index];

                  return PaymentCard(
  status: _getDisplayStatus(item.paymentStatus ?? ''),
  statusColor: _getStatusColor(item.paymentStatus ?? ''),
  operatorName: item.productName ?? '',
  amount: "₹ ${item.amount ?? '0'}",
  dateTime: item.dateTime ?? '',
  mobile: item.mobile ?? '',
  productLogo: item.productLogo ?? '',
);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  

 String _getDisplayStatus(String status) {
  switch (status.toLowerCase()) {
    case "success":
      return "Paid";

    case "failed":
      return "Pending";

    case "pending":
      return "Pending";

    default:
      return status;
  }
}

Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case "success":
      return Colors.green;

    case "failed":
    case "pending":
      return Colors.orange;

    default:
      return Colors.blue;
  }
}


  
}
class PaymentCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String operatorName;
  final String amount;
  final String dateTime;
  final String mobile;
  final String productLogo;

  const PaymentCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.operatorName,
    required this.amount,
    required this.dateTime,
    required this.mobile,
    required this.productLogo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2F3349)
            : AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: isDark
            ? Border.all(
                color: const Color(0xFF3C3F52),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// DATE & STATUS
          Row(
            children: [
              Text(
                "Date & Time:",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ),

              SizedBox(width: 6.w),

              Expanded(
                child: Text(
                  dateTime,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isDark
                        ? Colors.white70
                        : Colors.grey.shade700,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// PRODUCT + AMOUNT
          Row(
            children: [
            Container(
  width: 40.w,
  height: 40.h,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(6.r),
  ),
  child: Image.network(
    productLogo,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(
        Icons.image_not_supported,
      );
    },
  ),
),

              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      operatorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 2.h),

                    Text(
                      "Transaction No: $mobile",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? Colors.white70
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                amount,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          
        ],
      ),
    );
  }
}