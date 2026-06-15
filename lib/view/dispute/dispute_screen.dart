import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:maxpay/controllers/dispute_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
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
  print("UI LENGTH: ${controller.disputeList.length}");

  if (controller.disputeList.isEmpty) {
    return const Center(
      child: Text("No Data Found"),
    );
  }

  return ListView.builder(
    itemCount: controller.disputeList.length,
    itemBuilder: (context, index) {
      final item = controller.disputeList[index];

      return Card(
        child: ListTile(
          title: Text(item.subject ?? ""),
          subtitle: Text(item.status ?? ""),
        ),
      );
    },
  );
})
            ),
          ],
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