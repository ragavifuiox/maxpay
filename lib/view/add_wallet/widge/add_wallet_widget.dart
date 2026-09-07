import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_wallet_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/extension.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';

Widget transactionCard({
  required BuildContext context,
  required String status,
  required Color statusColor,
  String mode = "Worldline",
  required String amount,
  required String txnId,
  required String dateTime,
}) {
  final theme = Theme.of(context);

  return GestureDetector(
    onTap: status.toLowerCase() == 'pending'
        ? () {
            Get.find<AddWalletController>().checkIndividualPaymentStatus(
              txnId,
              amount,
            );
          }
        : null,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? AppColors.darkplceholder
            : AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: .all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "UTR NO: $txnId",
                  style: TextHelper.max12(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Date & Time:\n${dateTime.isNotEmpty ? formatTransactionDate(dateTime) : "-"}",
                  textAlign: TextAlign.end,
                  style: TextHelper.max12(context),
                ),
              ),
            ],
          ),

          const SizedBox(height: 1),
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
                  Text("Status", style: TextHelper.max12(context)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (status.toLowerCase() == 'pending') ...[
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Get.find<AddWalletController>()
                                .checkIndividualPaymentStatus(txnId, amount);
                          },
                          child: const Icon(
                            Icons.refresh,
                            size: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ] else ...[
                        const SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            text: "Paid With ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.totalborder1,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                            children: (mode == 'Worldline')
                                ? [
                                    TextSpan(
                                      text: "UPI",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.totalborder1,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://images.icon-icons.com/2699/PNG/512/upi_logo_icon_170312.png',
                                        height: 18,
                                        // errorBuilder: (context, error, stackTrace) =>
                                        //     const Icon(Ionicons.logo_paypal, size: 24),
                                      ),
                                    ),
                                  ]
                                : [
                                    TextSpan(
                                      text: "QR Code",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.totalborder1,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Amount", style: TextHelper.max12(context)),
                  const SizedBox(height: 5),
                  Text(amount.currencyIndian, style: TextHelper.max10(context)),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
