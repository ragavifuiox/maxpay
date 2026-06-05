import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/dispute/widget/disput_search.dart';

class DisputeReportScreen extends StatelessWidget {
  const DisputeReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: CommonAppBar(title: "Dispute Report"),

      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            /// FILTER BOX
            Disputefilter(),
              SizedBox(height: 18.h),
            Divider(
  color: Theme.of(context).brightness == Brightness.light
      ? Colors.black12
      : Colors.white24,
),

            SizedBox(height: 18.h),

            /// FAILED CARD
           const DisputeCardWidget(
              status: "Failed",
              statusColor: Colors.red,
              message:
                  "Due to network error your recharge has been rejected",
              messageColor: Colors.red,
            ),

            SizedBox(height: 14.h),

            /// SUCCESS CARD
            const DisputeCardWidget(
              status: "Success",
              statusColor: Colors.green,
              message:
                  "Recharge has been successfully completed",
              messageColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateField(
    BuildContext context, {
    required String hint,
  }) {
    final theme = Theme.of(context);

    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 12.sp,
        ),
        filled: true,
        fillColor: theme.brightness == Brightness.dark
            ? AppColors.darkplceholder
            : AppColors.background,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 12.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// ================= CARD =================

class DisputeCardWidget extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String message;
  final Color messageColor;

  const DisputeCardWidget({
    super.key,
    required this.status,
    required this.statusColor,
    required this.message,
    required this.messageColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
      ? AppColors.background
      : AppColors.darkplceholder,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Replay Time: 07:38:43PM",
                style: TextHelper.max18,
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
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
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),
 Divider(
  color: Theme.of(context).brightness == Brightness.light
      ? Colors.black12
      : Colors.white24,
),
 SizedBox(height: 10.h),
          /// SUBJECT
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Subject: ",
                  style: TextHelper.max19(context)
                ),


                TextSpan(
                  text: "Pre Paid Recharge",
                  style: TextHelper.max19(context),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          /// MESSAGE
          Text(
            message,
            style: TextStyle(
              color: messageColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}