import 'package:flutter/material.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';


class TransactionCard extends StatelessWidget {
  final TransrepData data;

  const TransactionCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final status =
        (data.status ?? "").toLowerCase();

    Color statusColor;

    if (status == "success") {
      statusColor = Colors.green;
    } else if (status == "pending") {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transaction ID : ${data.transactionId ?? '-'}",
              ),
              Text(
                data.dateTime ?? '',
              ),
            ],
          ),

          const SizedBox(height: 10),

          Divider(),

          const SizedBox(height: 10),

          Row(
            children: [
              /// Logo
              if ((data.logo ?? '').isNotEmpty)
                Image.network(
                  data.logo!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, _, _) => const Icon(
                    Icons.image,
                  ),
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                  child: Text(
                    data.operator
                                ?.substring(0, 1)
                                .toUpperCase() ??
                            "P",
                  ),
                ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.amount ?? '',
                    ),
                    Text(
                      "Number : ${data.mobile ?? ''}",
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${data.amount ?? '0'}",
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius:
                          BorderRadius.circular(
                        6,
                      ),
                    ),
                    child: Text(
                      data.status ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
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