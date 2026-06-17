import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:maxpay/controllers/payment_status_controller.dart';
import 'package:maxpay/controllers/refund_controller.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/refund/widget/refund_search.dart';
import 'package:maxpay/view/refund/widget/refund_widget.dart';


class RefundScreen extends GetView<RefundController> {
  const RefundScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,


      appBar: const CommonAppBar(title: "Refunds"),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            /// 🔹 Date Filter Row
            

           

            /// 🔹 Search
          const RefundSearch(),

            const SizedBox(height: 16),

           
     

            Divider(
  color: Theme.of(context).brightness == Brightness.light
      ? Colors.black12
      : Colors.white24,
),


            const SizedBox(height: 16),

            /// 🔹 List
            Expanded(
  child: Obx(() {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.refund.isEmpty) {
      return const Center(
        child: Text("No Data Found"),
      );
    }

    return ListView.builder(
      itemCount: controller.refund.length,
      itemBuilder: (context, index) {
        final item = controller.refund[index];

        return EarningsCard1(
          data: item,
        );
      },
    );
  }),
)
          ],
        ),
      ),
    );
  }
  }