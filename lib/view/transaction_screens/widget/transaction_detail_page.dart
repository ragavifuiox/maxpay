import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/core/constants/extension.dart';

class TransactionDetailsPage extends StatelessWidget {
  const TransactionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TransrepData data = Get.arguments;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(title: "View Details"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2F3349) : const Color(0xFFE5FBFF),
              borderRadius: BorderRadius.circular(12),
              border: isDark
                  ? Border.all(color: const Color(0xFF3C3F52))
                  : null,
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.transparent : Colors.grey.shade300,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Important
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productRow(context, "Product Name", data.productLogo),

                detailRow(
                  context,
                  "Payment Status",
                  (data.paymentStatus?.toLowerCase() == 'received')
                      ? 'Success'
                      : (data.paymentStatus ?? "-"),
                  textColor:
                      (data.paymentStatus?.toLowerCase() == 'received' ||
                          data.paymentStatus?.toLowerCase() == 'success')
                      ? Colors.green
                      : null,
                ),

                detailRow(context, "Transaction No", data.transactionNo ?? "-"),

                detailRow(
                  context,
                  "Available Balance",
                  (data.availableBalance ?? "0").currencyIndian,
                ),

                detailRow(
                  context,
                  "Transaction Amount",
                  (data.transactionAmount ?? "0").currencyIndian,
                ),

                detailRow(
                  context,
                  "Commission",
                  (data.commission ?? "0").currencyIndian,
                ),

                detailRow(
                  context,
                  "Remaining Balance",
                  (data.remainingBalance ?? "0").currencyIndian,
                ),

                detailRow(
                  context,
                  "Request Date & Time",
                  (data.requestDateTime?.isNotEmpty ?? false)
                      ? formatTransactionDate(data.requestDateTime ?? '-')
                      : "-",
                ),

                detailRow(
                  context,
                  "Response Date & Time",
                  (data.responseDateTime?.isNotEmpty ?? false)
                      ? formatTransactionDate(data.responseDateTime ?? '-')
                      : "-",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailRow(
    BuildContext context,
    String title,
    String value, {
    Color? textColor,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface),
          ),

          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor ?? theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget productRow(BuildContext context, String title, String? imageUrl) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface),
          ),

          imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  height: 35,
                  width: 35,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 35,
                      color: theme.colorScheme.onSurface,
                    );
                  },
                )
              : Text(
                  "-",
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
        ],
      ),
    );
  }
}
