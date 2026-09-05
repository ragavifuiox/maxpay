import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_staff_controller.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/staff/widget/trans_fileter_report.dart';
import 'package:maxpay/view/transaction_screens/widget/transaction_card.dart';

class TransactionReportScreen extends StatefulWidget {
  final String mobileNumber;
  const TransactionReportScreen({super.key, required this.mobileNumber});

  @override
  State<TransactionReportScreen> createState() =>
      _TransactionReportScreenState();
}

class _TransactionReportScreenState extends State<TransactionReportScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.logError("Mobile Number: ${widget.mobileNumber}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final now = DateTime.now();
      final dateStr =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      Get.find<AddStaffController>().getStaffTransactionReport(
        prdt: "",
        search: "",
        fromdate: dateStr,
        todate: dateStr,
        status: "SUCCESS",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddStaffController>();
    return Scaffold(
      appBar: CommonAppBar(title: "Transaction Report"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 10),
            TransactionFilterWidget(
              onFilter: (status, fromDate, toDate, search, prdtId) {
                AppLogger.logError("Status: $status");
                AppLogger.logError("From: $fromDate");
                AppLogger.logError("To: $toDate");
                AppLogger.logError("Search: $search");
                // Call your API or controller method to filter the data here!
                Get.find<AddStaffController>().getStaffTransactionReport(
                  prdt: prdtId,
                  search: search,
                  fromdate: fromDate,

                  todate: toDate,
                  status: status,
                );
              },
            ),

            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if ((controller.transReport.value.list ?? []).isEmpty) {
                  return const Center(child: Text("No Data Found"));
                }

                return ListView.builder(
                  itemCount: (controller.transReport.value.list ?? []).length,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                      data: controller.transReport.value.list![index],
                      isClickable: false,
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
}
