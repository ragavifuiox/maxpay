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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar(title: "Payment Status"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            const PaymentFilterBox(),

            SizedBox(height: 16.h),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.paymentstatus.isEmpty) {
                  return const Center(child: Text("No Data Found"));
                }

                return ListView.separated(
                  itemCount: controller.paymentstatus.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = controller.paymentstatus[index];

                    final currentDisplayStatus = _getDisplayStatus(
                      item.paymentStatus ?? '',
                    );

                    return PaymentCard(
                      status: currentDisplayStatus,
                      statusColor: _getStatusColor(item.paymentStatus ?? ''),
                      operatorName: item.productName ?? '',
                      amount: "₹ ${item.amount ?? '0'}",
                      dateTime: item.dateTime ?? '',
                      mobile: item.mobile ?? '',
                      productLogo: item.productLogo ?? '',

                      selectedStatus: "Select",

                      statusList: currentDisplayStatus == "Paid"
                          ? const ["Select", "Pending"]
                          : const ["Select", "Paid"],
                      onChanged: (value) {
                        if (value == null || value == "Select") return;

                        _showStatusDialog(
                          context: context,
                          controller: controller,
                          rechargeId: item.id.toString(),
                          status: value,
                        );
                      },
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
      case "received":
        return "Paid";

      case "not_received":
        return "Pending";

      case "pending":
        return "Pending";

      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "received":
        return Colors.green;

      case "not_received":
      case "pending":
        return Colors.orange;

      default:
        return Colors.blue;
    }
  }
}

void _showStatusDialog({
  required BuildContext context,
  required PaymentStatusController controller,
  required String rechargeId,
  required String status,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  Get.defaultDialog(
    title: "Payment Status",
    titleStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: isDark ? Colors.white : Colors.black,
    ),
    middleText:
        "Are you sure you want to change the payment status to '$status'?",
    middleTextStyle: TextStyle(
      fontSize: 12,
      color: isDark ? Colors.white70 : Colors.black87,
    ),
    backgroundColor: isDark ? const Color(0xFF2F3349) : Colors.white,
    radius: 12,

    textCancel: "Cancel",
    textConfirm: "OK",

    cancelTextColor: Colors.black,
    confirmTextColor: Colors.white,

    buttonColor: AppColors.clrPrimary,

    onConfirm: () async {
      Get.back();

      String apiStatus;

      switch (status) {
        case "Paid":
          apiStatus = "received";
          break;
        case "Pending":
          apiStatus = "not_received";
          break;
        default:
          apiStatus = status.toLowerCase();
      }

      await controller.updatePaymentStatus(
        rechargeId: rechargeId,
        status: apiStatus,
      );
    },
  );
}

class PaymentCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String operatorName;
  final String amount;
  final String dateTime;
  final String mobile;
  final String productLogo;

  final String selectedStatus;
  final List<String> statusList;
  final ValueChanged<String?> onChanged;

  const PaymentCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.operatorName,
    required this.amount,
    required this.dateTime,
    required this.mobile,
    required this.productLogo,
    required this.selectedStatus,
    required this.statusList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2F3349) : AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: isDark ? Border.all(color: const Color(0xFF3C3F52)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Date & Status
          Row(
            children: [
              Text(
                "Date & Time:",
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  dateTime,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isDark ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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

          /// Product
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
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      operatorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Transaction No: $mobile",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                amount,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// Dropdown
          Row(
            children: [
              const Spacer(),

              Text(
                "Status",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),

              SizedBox(width: 10.w),

              SizedBox(
                width: 120.w,
                height: 36.h,
                child: DropdownButtonFormField<String>(
                  initialValue: selectedStatus,
                  isExpanded: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 8.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: statusList.map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status, style: TextStyle(fontSize: 12.sp)),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
