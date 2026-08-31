import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/controllers/add_staff_controller.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
import 'package:maxpay/view/staff/transaction_report.dart';

class StaffCardWidget extends StatelessWidget {
  final Data data;

  const StaffCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          _rowWidget(context, "Staff Name", data.name ?? ""),

          SizedBox(height: 10.h),
          _rowWidget(context, "UserId", data.userId ?? ""),
          SizedBox(height: 10.h),

          _rowWidget(context, "Reg.Mob No", data.mobile ?? ""),

          SizedBox(height: 10.h),

          _rowWidget(context, "Package Name", data.packageName ?? ""),

          SizedBox(height: 10.h),

          _rowWidget(
            context,
            "Wallet Balance",
            (data.walletBalance ?? '0').currencyIndian,
          ),

          SizedBox(height: 14.h),

          Row(
            children: [
              _buttonWidget(
                title: "Transaction Report",
                color: Colors.blue,
                onTap: () {
                  Get.put(
                    TransReportController(
                      transreportUsecase: sl(),
                      producttypeUseCase: sl(),
                      submitDisputeUsecase: sl(),
                      totalTransactionUsecase: sl(),
                      cashbackTypeUsecase: sl(),
                    ),
                  );
                  Get.to(
                    () => TransactionReportScreen(
                      mobileNumber: data.mobile ?? "",
                    ),
                  );
                },
              ),

              SizedBox(width: 8.w), // Gap

              _buttonWidget(
                title: "Wallet Report",
                color: Colors.red,
                onTap: () {
                  Get.toNamed(AppRoutes.walletreport);
                },
              ),

              SizedBox(width: 8.w), // Gap

              _buttonWidget(
                title: "Add Wallet",
                color: Colors.green,
                onTap: () {
                  Get.toNamed(AppRoutes.wallettrnsfer, arguments: data);
                },
              ),

              const Spacer(),

              InkWell(
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Text("Delete Staff"),
                      content: const Text(
                        "Are you sure you want to delete this staff?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Close popup
                            Get.back();

                            // Trigger deletion using user ID
                            Get.find<AddStaffController>().deleteStaff(
                              data.id.toString(),
                            );
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Icon(Icons.delete, color: Colors.red, size: 20.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rowWidget(BuildContext context, String title, String value) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextHelper.max16(context)),

        Text(
          title == "Staff Name"
              ? (value.isNotEmpty
                    ? value[0].toUpperCase() + value.substring(1)
                    : value)
              : value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: title == "Staff Name"
                ? Colors.green
                : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buttonWidget({
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 8.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
