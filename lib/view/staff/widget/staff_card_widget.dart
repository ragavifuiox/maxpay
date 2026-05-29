import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
class StaffCardWidget extends StatelessWidget {

  final Data data;

  const StaffCardWidget({
    super.key,
    required this.data,
  });

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
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [

          _rowWidget(
            context,
            "Staff Name",
            data.name ?? "",
          ),

          SizedBox(height: 10.h),
          _rowWidget(
            context,
            "UserId",
            data.userId ?? "",
          ),
  SizedBox(height: 10.h),

          _rowWidget(
            context,
            "Reg.Mob No",
            data.mobile ?? "",
          ),

          SizedBox(height: 10.h),

          _rowWidget(
            context,
            "Package Name",
            data.packageName ?? "",
          ),

          SizedBox(height: 10.h),

          _rowWidget(
            context,
            "Wallet Balance",
            "₹${data.walletBalance ?? "0"}",
          ),

          SizedBox(height: 14.h),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [

              _buttonWidget(
                title: "Transaction Report",
                color: Colors.blue,
              ),

              _buttonWidget(
                title: "Wallet Report",
                color: Colors.red,
              ),

              _buttonWidget(
                title: "Add Wallet",
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rowWidget(
    BuildContext context,
    String title,
    String value,
  ) {

    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [

        Text(
          title,
          style: TextHelper.max16(context),
        ),

        Text(
          value,
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
  }) {

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 5.h,
      ),
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
    );
  }
}