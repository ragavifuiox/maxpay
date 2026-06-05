import 'package:flutter/material.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/staff/widget/trans_fileter_report.dart';

class TransactionReportScreen extends StatelessWidget {
  const TransactionReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Transaction Report",
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          
          children: const [

            
            SizedBox(height: 10),
TransactionFilterWidget(),
            TransactionCard(
              bgColor: Color(0xFFD1FFE8),
              status: "success",
            ),

            SizedBox(height: 12),

            TransactionCard(
              bgColor: Color(0xFFFFE4E8),
              status: "failed",
            ),

            SizedBox(height: 12),

            TransactionCard(
              bgColor: Color(0xFFFFF1DB),
              status: "processing",
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
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                  Text(
                    "Date & Time:",
                     style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "29-11-2026 07:38:43PM",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurfaceVariant,
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
                child:  Text(
                  "Jio",
                   style: TextStyle(
                   color:
            Theme.of(context).brightness ==
                    Brightness.dark
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
                        color:
            Theme.of(context).brightness ==
                    Brightness.dark
                ? Colors.black
                : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Number: 9865647823",
                       style: TextStyle(
                        fontSize: 11,
                        color:
            Theme.of(context).brightness ==
                    Brightness.dark
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
                      color:
            Theme.of(context).brightness ==
                    Brightness.dark
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
                  _button(
                    title: "Dispute",
                    color: Colors.red,
                  ),
                  const SizedBox(width: 6),
                  _button(
                    title: "View",
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 6),
                  _button(
                    title: "Share",
                    color: Colors.green,
                  ),
                ],

                if (status == "failed") ...[
                  _button(
                    title: "Failed",
                    color: Colors.red,
                  ),
                  const SizedBox(width: 6),
                  _button(
                    title: "View",
                    color: Colors.blue,
                  ),
                ],

                if (status == "processing")
                  _button(
                    title: "Processing",
                    color: Colors.orange,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _button({
    required String title,
    required Color color,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 5,
        ),
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