import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/extension.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/view/transaction_screens/widget/daispute_dialogue..dart';
import 'package:maxpay/view/transaction_screens/widget/share_receipt.dart';

class TransactionCard extends StatelessWidget {
  final TransrepData data;

  const TransactionCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final status = (data.status ?? "").trim().toLowerCase();

    final isSuccess = status == "success" || status == "received";
    final isPending = status == "pending";
    final isFailed = !isSuccess && !isPending;

    Color statusColor;
    Color bgColor;

    if (status == "success" || status == "received") {
      statusColor = Colors.green;
      bgColor = const Color(0xFFE8F8EC);
    } else if (status == "pending") {
      statusColor = Colors.orange;
      bgColor = const Color(0xFFFFF4E5);
    } else {
      statusColor = Colors.red;
      bgColor = const Color(0xFFFFEBEE);
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Transaction ID: ${data.transactionId ?? '-'}",
                  style: TextHelper.max1.copyWith(color: AppColors.darktextclr),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date & Time",
                    style: TextHelper.max1.copyWith(
                      color: AppColors.darktextclr,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.dateTime != null && data.dateTime!.isNotEmpty
                        ? formatTransactionDate(data.dateTime!)
                        : "-",
                    style: TextHelper.max1.copyWith(
                      color: AppColors.darktextclr,
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// Header
          //
          const SizedBox(height: 10),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 10),

          Row(
            children: [
              if ((data.logo ?? '').isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.network(
                    data.logo!,
                    width: 42,
                    height: 42,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => _defaultLogo(),
                  ),
                )
              else
                _defaultLogo(),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.operator ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Number : ${data.mobile ?? ''}",
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data.amount ?? '0',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Action Buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSuccess) ...[
                    _button("Dispute", Colors.red, () {
                      showDialog(
                        context: context,
                        builder: (_) =>
                            DisputeDialog(rechargeId: data.id.toString()),
                      );
                    }),
                    const SizedBox(width: 6),
                    _button("Success", statusColor, () {
                      Get.toNamed(
                        AppRoutes.transactionDetails,
                        arguments: data,
                      );
                    }),

                    const SizedBox(width: 6),
                    _button("Share", Colors.blue, () {
                      ShareReceipt.shareScreenshot(
                        context: context,
                        data: data,
                      );
                    }),
                  ],

                  if (isPending)
                    _button("Processing", Colors.orange, () {
                      Get.toNamed(
                        AppRoutes.transactionDetails,
                        arguments: data,
                      );
                    }),

                  if (isFailed) ...[
                    _button("Failed", statusColor, () {
                      Get.toNamed(
                        AppRoutes.transactionDetails,
                        arguments: data,
                      );
                    }),

                    const SizedBox(width: 6),

                    _button("Resend", Colors.green, () {
                      print("========== RESEND ==========");
                      print("ID: ${data.id}");
                      print("Transaction ID: ${data.transactionId}");
                      print("Product Type: ${data.productType}");
                      print("Mobile: ${data.mobile}");
                      print("Amount: ${data.amount}");
                      print("Status: ${data.status}");
                      print("Logo: ${data.logo}");

                      _onResend(context);
                    }),
                  ],
                ],
              ),

              const SizedBox(width: 8),

              // Status Badge
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 12,
              //     vertical: 7,
              //   ),
              //   decoration: BoxDecoration(
              //     color: statusColor,
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              //   child: Text(
              //     status == "received" ? "Success" : (data.status ?? ""),
              //     style: const TextStyle(
              //       fontSize: 10,
              //       fontWeight: FontWeight.w600,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _defaultLogo() {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Text(
        "J",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _button(String title, Color color, VoidCallback onTap) {
    return SizedBox(
      height: 28,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  void _onResend(BuildContext context) {
    final productType = (data.productType ?? "").toLowerCase();
    final productTypeId = (data.productTypeId ?? "").toString();

    final String productId = data.productId?.toString() ?? "";

    print("========== RESEND ==========");
    print("Product ID: $productId");
    print("Product Type: ${data.productType}");
    print("Product Type ID: ${data.productTypeId}");

    if (productType.contains("prepaid") ||
        productType.contains("mobile") ||
        productTypeId == "1") {
      Get.toNamed(
        AppRoutes.transconfirm,
        arguments: {
          "mobileNumber": data.mobile,
          "amount": data.amount,
          "productdetid": productId,

          "paymentStatus": data.paymentStatus ?? "Pending",
          "operator": data.operator ?? "",
          "logo": data.logo ?? "",
          "availableBalance": data.availableBalance ?? "0",

          // DON'T use failed report commission
          "isFromTranactionPage": true,
        },
      );
    }
  }
}
