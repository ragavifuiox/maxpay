import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class TransactionDetailsPage extends StatelessWidget {
  const TransactionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final TransrepData data = Get.arguments;

    return Scaffold(
      appBar: CommonAppBar(title: "View Details"),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
productRow(
  "Product Name",
  data.productLogo,
),

              detailRow(
                "Payment Status",
                data.paymentStatus ?? "-"
              ),

              detailRow(
                "Transaction No",
                data.transactionNo ?? "-"
              ),

              detailRow(
                "Available Balance",
                "₹${data.availableBalance ?? "0"}"
              ),

              detailRow(
                "Transaction Amount",
                "₹${data.transactionAmount ?? "0"}"
              ),

              detailRow(
                "Commission",
                "₹${data.commission ?? "0"}"
              ),

              detailRow(
                "Surcharge",
                "₹${data.surcharge ?? "0"}"
              ),

              detailRow(
                "Remaining Balance",
                "₹${data.remainingBalance ?? "0"}"
              ),

              detailRow(
                "Request Date&Time",
                data.requestDateTime ?? "-"
              ),

              detailRow(
                "Response Date&Time",
                data.responseDateTime ?? "-"
              ),

            ],
          ),
        ),
      ),
    );
  }


  Widget detailRow(String title,String value){

    return Padding(
      padding: const EdgeInsets.only(bottom:12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize:12,
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontSize:12,
              fontWeight: FontWeight.w600,
            ),
          ),

        ],
      ),
    );
  }
  Widget productRow(String title, String? imageUrl) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),

        imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                height: 35,
                width: 35,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 35,
                  );
                },
              )
            : const Text(
                "-",
                style: TextStyle(fontSize: 12),
              ),
      ],
    ),
  );
}
}