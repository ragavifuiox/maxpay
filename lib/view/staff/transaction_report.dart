import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_staff_controller.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/staff/widget/trans_fileter_report.dart';

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
        search: widget.mobileNumber,
        fromdate: dateStr,
        todate: dateStr,
        status: "",
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
        child: ListView(
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
                      bgColor:
                          controller.transReport.value.list![index].status ==
                              "success"
                          ? Color(0xFFD1FFE8)
                          : controller.transReport.value.list![index].status ==
                                "failed"
                          ? Color(0xFFFFE4E8)
                          : Color(0xFFFFF1DB),
                      status: controller.transReport.value.list![index].status!,
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

class TransactionCard extends StatelessWidget {
  final Color bgColor;
  final String status;

  const TransactionCard({
    super.key,
    required this.bgColor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          /// HEADER
          Row(
            children: [
              Expanded(
                child: Text(
                  "Transaction ID: TXN6453564",
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date & Time:",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "29-11-2026 07:38:43PM",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Divider(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black12
                : Colors.white24,
          ),

          const SizedBox(height: 12),

          /// BODY
          Row(
            children: [
              /// LOGO
              Container(
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Jio",
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.white,

                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jio",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Number: 9865647823",
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              /// AMOUNT
              Text(
                "₹ 365.00",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// BUTTONS
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (status == "success") ...[
                  _button(title: "Dispute", color: Colors.red),
                  const SizedBox(width: 6),
                  _button(title: "View", color: Colors.blue),
                  const SizedBox(width: 6),
                  _button(title: "Share", color: Colors.green),
                ],

                if (status == "failed") ...[
                  _button(title: "Failed", color: Colors.red),
                  const SizedBox(width: 6),
                  _button(title: "View", color: Colors.blue),
                ],

                if (status == "processing")
                  _button(title: "Processing", color: Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _button({required String title, required Color color}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
