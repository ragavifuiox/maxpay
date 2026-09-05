import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/snackbar.dart';
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
  final bool isClickable;

  const TransactionCard({
    super.key,
    required this.data,
    this.isClickable = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final status = (data.status ?? "").trim().toLowerCase();

    final isSuccess = status == "success" || status == "received";
    final isPending = status == "processing" || status == "pending";
    final isFailed = !isSuccess && !isPending;

    Color statusColor;
    Color bgColor;

    if (isSuccess) {
      statusColor = Colors.green;
      bgColor = const Color(0xFFE8F8EC);
    } else if (isPending) {
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
                  "Transaction ID: ${data.transactionNo ?? data.transactionId ?? '-'}",
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  final String copyData =
                      '''
Transaction ID: ${data.transactionNo ?? '-'}
Date & Time: ${data.dateTime != null && data.dateTime!.isNotEmpty ? formatTransactionDate(data.dateTime!) : "-"}
Operator: ${data.operator ?? ''}
Number: ${data.mobile ?? ''}
Amount: ${data.amount ?? '0'}
Status: ${isSuccess ? 'Success' : (isPending ? 'Processing' : 'Failed')}
'''
                          .trim();

                  Clipboard.setData(ClipboardData(text: copyData)).then((_) {
                    CustomToast.success('Copied');
                  });
                },

                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.copy,
                    size: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    if (isSuccess) ...[
                      _button("Dispute", Colors.red, () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              DisputeDialog(rechargeId: data.id.toString()),
                        );
                      }),
                      _button("Success", statusColor, () {
                        if (!isClickable) return;
                        Get.toNamed(
                          AppRoutes.transactionDetails,
                          arguments: data,
                        );
                      }),
                      _button("Share", Colors.blue, () {
                        ShareReceipt.shareScreenshot(
                          context: context,
                          data: data,
                        );
                      }),
                    ],
                    if (isPending)
                      _button("Processing", Colors.orange, () {
                        if (!isClickable) return;
                        Get.toNamed(
                          AppRoutes.transactionDetails,
                          arguments: data,
                        );
                      }),
                    if (isFailed) ...[
                      _button("Failed", statusColor, () {
                        if (!isClickable) return;
                        Get.toNamed(
                          AppRoutes.transactionDetails,
                          arguments: data,
                        );
                      }),
                      _button("Resend", Colors.green, () {
                        final dtStr = data.dateTime;
                        DateTime? parsedTime;

                        if (dtStr != null && dtStr.isNotEmpty) {
                          try {
                            final normalized = dtStr.replaceAll(' ', 'T');
                            parsedTime = DateTime.tryParse(
                              normalized +
                                  (normalized.contains('Z') ||
                                          normalized.contains('+')
                                      ? ""
                                      : "Z"),
                            );
                          } catch (_) {}

                          if (parsedTime == null) {
                            final formattedDate = formatTransactionDate(dtStr);
                            if (formattedDate != '-' &&
                                formattedDate != dtStr) {
                              try {
                                parsedTime = DateFormat(
                                  'dd-MM-yyyy, hh:mm a',
                                ).parseLoose(formattedDate);
                              } catch (_) {}
                            }
                          }
                        }

                        bool isExpired = false;
                        if (parsedTime != null) {
                          final diff = DateTime.now()
                              .difference(parsedTime.toLocal())
                              .inSeconds;
                          if (diff > 10800) {
                            isExpired = true;
                          }
                        }

                        if (isExpired) {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: const Text("Notice"),
                              content: const Text(
                                "A transaction can only be resent within 3 hours of being created.",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Close"),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        _onResend(context);
                      }),
                    ],
                  ],
                ),
              ),
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

          "isFromTranactionPage": true,
        },
      );
    } else if (productType.contains("dth") || productTypeId == "2") {
      Get.toNamed(
        AppRoutes.confirmdth,
        arguments: {
          "customerId": data.mobile,
          "amount": data.amount,
          "productdetid": productId,
          "paymentStatus": data.paymentStatus ?? "Pending",
          "operator": data.operator ?? "",
          "logo": data.logo ?? "",
          "availableBalance": data.availableBalance ?? "0",

          "isFromTranactionPage": true,
        },
      );
    }
  }
}
