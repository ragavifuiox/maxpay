import 'package:flutter/material.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/view/transaction_screens/widget/daispute_dialogue..dart';

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
    Color bgColor;

    if (status == "success") {
      statusColor = Colors.green;
      bgColor = const Color(0xFFE2F8E9);
    } else if (status == "pending") {
      statusColor = Colors.orange;
      bgColor = const Color(0xFFFFF1DD);
    } else {
      statusColor = Colors.red;
      bgColor = const Color(0xFFFFE4E6);
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
          /// Header
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Transaction ID: ${data.transactionId ?? '-'}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black
                  ),
                ),
              ),
              Text(
                data.dateTime ?? "",
                style: const TextStyle(
                  fontSize: 11,
                   color: Colors.black
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Divider(
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 10),

          /// Content
          Row(
            children: [
              /// Logo
              if ((data.logo ?? '').isNotEmpty)
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(0),
                  child: Image.network(
                    data.logo!,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, _, _) =>
                            _defaultLogo(),
                  ),
                )
              else
                _defaultLogo(),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.operator ?? "",
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.w600,
                             color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Number : ${data.mobile ?? ''}",
                      style: const TextStyle(
                        fontSize: 12,
                         color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Text(
                    data.amount ?? '0',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                           color: Colors.black
                    ),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius:
                          BorderRadius.circular(
                        5,
                      ),
                    ),
                    child: Text(
                      data.status ?? "",
                      style: const TextStyle(
                        
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w600,
                             color: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Bottom Buttons
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end,
            children: [
              if (status == "success") ...[
                _button(
  "Dispute",
  Colors.red,
  () {
    showDialog(
      context: context,
      builder: (_) => DisputeDialog(
        rechargeId:(data.id ?? 0).toString(),
      ),
    );
  },
),
                const SizedBox(width: 6),
                _button(
                  "View",
                  Colors.blue,
                  () {},
                ),
                const SizedBox(width: 6),
                _button(
                  "Share",
                  Colors.green,
                  () {},
                ),
              ],

              if (status == "pending")
                _button(
                  "Processing",
                  Colors.orange,
                  () {},
                ),

              if (status == "failed") ...[
                _button(
                  "View",
                  Colors.blue,
                  () {},
                ),
                const SizedBox(width: 6),
                _button(
                  "Resend",
                  Colors.green,
                  () {},
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _defaultLogo() {
    return Container(
      width: 40,
      height: 40,
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
        ),
      ),
    );
  }

  Widget _button(
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return SizedBox(
      height: 28,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          minimumSize: Size.zero,
          tapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(6),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}