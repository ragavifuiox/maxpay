import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:maxpay/controllers/dispute_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/dispute/widget/disput_search.dart';

class DisputeReportScreen extends GetView<DisputeController> {
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
            const Disputefilter(),

            SizedBox(height: 18.h),

            Divider(
              color: theme.brightness == Brightness.light
                  ? Colors.black12
                  : Colors.white24,
            ),

            SizedBox(height: 18.h),

           Expanded(
  child: Obx(() {
    if (controller.disputeList.isEmpty) {
      return const Center(
        child: Text("No Data Found"),
      );
    }

    return ListView.separated(
      itemCount: controller.disputeList.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final item = controller.disputeList[index];

        final bool isSuccess =
            (item.status ?? "").toLowerCase() == "success";

        return DisputeCardWidget(
          status: item.status ?? "Pending",
          statusColor: isSuccess
              ? Colors.green
              : Colors.red,

          message: item.adminReply?.isNotEmpty == true
              ? item.adminReply!
              : (item.description ?? ""),

          messageColor: isSuccess
              ? Colors.green
              : Colors.red,

          subject: item.subject ?? "-",

          replyTime: item.updatedAt ?? "",
        );
      },
    );
  }),
)        ],
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
  final String subject;
  final String replyTime;

  const DisputeCardWidget({
    super.key,
    required this.status,
    required this.statusColor,
    required this.message,
    required this.messageColor,
    required this.subject,
    required this.replyTime,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? const Color(0xffF6F6FB)
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
              Expanded(
                child: Text(
                  "Replay Time: $replyTime",
                   style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
                  fontWeight: FontWeight.w500,
                ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 3.h,
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

          SizedBox(height: 10.h),

          Divider(
            color: theme.brightness == Brightness.light
                ? Colors.black12
                : Colors.white24,
          ),

          SizedBox(height: 8.h),

          /// SUBJECT
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Subject: ",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins'
                   
                  ),
                ),
                TextSpan(
                  text: subject,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w500,
                      fontFamily: 'poppins'
                  ),
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
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'poppins'
            ),
          ),
        ],
      ),
    );
  }
}