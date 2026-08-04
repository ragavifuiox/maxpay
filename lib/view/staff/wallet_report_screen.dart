import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_staff_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/extension.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/staff/widget/wallet_report_filter.dart';

class WalletReportScreen extends StatefulWidget {
  const WalletReportScreen({super.key});

  @override
  State<WalletReportScreen> createState() => _WalletReportScreenState();
}

class _WalletReportScreenState extends State<WalletReportScreen> {
  final AddStaffController controller = Get.find<AddStaffController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.fromDate.isEmpty || controller.toDate.isEmpty) {
        final now = DateTime.now();
        final formattedDate =
            "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

        controller.fromDate = formattedDate;
        controller.toDate = formattedDate;
        controller.update();

        controller.searchcredit(
          search: controller.search,
          paymenttype: controller.selectedcreditname.value,
          fromdate: controller.fromDate,
          todate: controller.toDate,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Wallet Report"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const WalletReportFilterWidget(),
            const SizedBox(height: 15),

            Expanded(
              child: GetBuilder<AddStaffController>(
                builder: (controller) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.walletreport.isEmpty) {
                    return const Center(child: Text("No Data Found"));
                  }

                  return ListView.builder(
                    itemCount: controller.walletreport.length,
                    itemBuilder: (_, index) {
                      final item = controller.walletreport[index];

                      return walletCard(
                        context: context,
                        txnId: item.id?.toString() ?? "-",
                        transferType: item.paymentType ?? "-",
                        amount: item.amount ?? "0",
                        dateTime: formatTransactionDate(item.createdAt ?? "-"),
                        color:
                            (item.paymentType ?? "").toLowerCase().contains(
                              "reverse",
                            )
                            ? Colors.red
                            : Colors.green,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget walletCard({
    required BuildContext context,
    required String txnId,
    required String transferType,
    required String amount,
    required String dateTime,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.background
            : const Color(0xFF2F3349),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Transaction ID : $txnId",
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
                    "Date & Time",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    dateTime,
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Divider(
            color: theme.brightness == Brightness.light
                ? Colors.black12
                : Colors.white24,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transaction Type",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      transferType,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "₹ $amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
