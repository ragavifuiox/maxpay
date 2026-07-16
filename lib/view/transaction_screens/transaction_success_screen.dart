import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/transaction_screens/widget/transaction_card.dart';

enum TransactionStatus { success, pending, failed }

class TransactionScreen extends GetView<TransReportController> {
  final TransactionStatus status;

  const TransactionScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    controller.currentStatus = status.name;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.transreportList.isEmpty) {
        controller.transactionreport(
          search: controller.search,
          status: controller.currentStatus,
          productid: controller.selectedProductId.value,
          fromdate: controller.fromDate,
          todate: controller.toDate,
        );
      }
    });
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isSuccess = status == TransactionStatus.success;
    final bool isPending = status == TransactionStatus.pending;

    Color bgColor;
    String title;

    if (isSuccess) {
      bgColor = isDark ? const Color(0xFFE2F8E9) : const Color(0xFFE2F8E9);

      title = "Transaction Success";
    } else if (isPending) {
      bgColor = isDark ? const Color(0xFFFFF1DD) : const Color(0xFFFFF1DD);

      title = "Transaction Pending";
    } else {
      bgColor = isDark ? const Color(0xFFFFE4E6) : const Color(0xFFFFE4E6);

      title = "Transaction Failed";
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: CommonAppBar(title: title),

      body: Padding(
        padding: const EdgeInsets.all(14),

        child: Column(
          children: [
            /// FILTER CONTAINER
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? const Color(0xFFE3F0FB)
                    : AppColors.darkplceholder,
                borderRadius: BorderRadius.circular(10),
                border: theme.brightness == Brightness.light
                    ? Border.all(color: const Color(0xFFB5D4F4))
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  /// SELECT CREDIT TYPE
                  Obx(() {
                    final productList =
                        controller.producttype.value?.data ?? [];

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.light
                            ? Colors.white
                            : AppColors.darkplceholder,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.brightness == Brightness.light
                              ? const Color(0xFFD6D6D6)
                              : const Color.fromARGB(255, 159, 159, 159),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,

                          value:
                              productList.any(
                                (e) =>
                                    e.id.toString() ==
                                    controller.selectedProductId.value,
                              )
                              ? controller.selectedProductId.value
                              : null,

                          hint: const Text("Select"),

                          items: productList.map((item) {
                            return DropdownMenuItem<String>(
                              value: item.id.toString(),
                              child: Text(item.name ?? ""),
                            );
                          }).toList(),

                          onChanged: (value) {
                            if (value == null) return;

                            controller.selectedProductId.value = value;

                            controller.transactionreport(
                              search: controller.search,
                              status: status.name,
                              productid: value,
                              fromdate: controller.fromDate,
                              todate: controller.toDate,
                            );
                          },
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 10),

                  /// Show Total Transaction Amount only for Success & Failed

                  /// DATE FIELDif (!isPending) ...[
                  /// DATE FIELD
                  if (!isPending) ...[
                    /// DATE FIELD
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectFromDate(context),
                            child: GetBuilder<TransReportController>(
                              id: "fromDate",
                              builder: (controller) {
                                return customField(
                                  context,
                                  controller: controller.fromDateController,
                                  readOnly: true,
                                  onTap: () =>
                                      controller.selectFromDate(context),
                                  hint: '',
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.arrow_forward,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectToDate(context),
                            child: GetBuilder<TransReportController>(
                              id: "toDate",
                              builder: (_) {
                                return customField(
                                  context,
                                  controller: controller.toDateController,
                                  hint: "End Date",
                                  readOnly: true,
                                  onTap: () => controller.selectToDate(context),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 10),

                  /// SEARCH FIELD
                  customField(context, hint: "Search", prefix: Icons.search),
                ],
              ),
            ),

            const SizedBox(height: 15),
            Divider(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black12
                  : Colors.white24,
            ),
            const SizedBox(height: 15),
            if (!isPending) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.clrPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Total Transaction",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹56.00",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],

            /// TRANSACTION LIST
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.transreportList.isEmpty) {
                  return const Center(child: Text("No Data Found"));
                }

                return ListView.builder(
                  itemCount: controller.transreportList.length,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                      data: controller.transreportList[index],
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

  Widget customField(
    BuildContext context, {
    required String hint,
    IconData? prefix,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? Colors.white
            : AppColors.darkplceholder,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? const Color(0xFFD6D6D6)
              : const Color.fromARGB(255, 159, 159, 159),
        ),
      ),
      child: Row(
        children: [
          if (prefix != null) ...[
            Icon(prefix, size: 18, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              readOnly: readOnly,
              onTap: onTap,
              style: TextHelper.max1.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextHelper.max1.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
