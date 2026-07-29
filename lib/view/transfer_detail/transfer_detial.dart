import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:maxpay/controllers/wallet_trnasfer_detail_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/global_widget/custom_app.dart';

import 'package:maxpay/view/transfer_detail/transaction_card.dart';
import 'package:maxpay/view/transfer_detail/transaction_summary_card.dart';

import 'package:maxpay/view/transfer_detail/transferdetail_filter.dart';
import 'package:maxpay/view/transfer_detail/wallet_trnasfer.dart';

class TransferDetial extends StatefulWidget {
  const TransferDetial({super.key});

  @override
  State<TransferDetial> createState() => _TransferDetialState();
}

class _TransferDetialState extends State<TransferDetial> {
  TransferFilterType? _selectedFilter;
  final String _searchQuery = "";
 final WalletTrnasferDetailController controller = Get.put(WalletTrnasferDetailController(walletTransferDetailUseCase: sl(), staffWalletReverseUsecase: sl()));


  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Transfer Detail"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
         TransferdetailFilter(
  selectedFilter: _selectedFilter,
  onFilterChanged: (value) {
    setState(() {
      _selectedFilter = value;
    });

    // update transaction type
    controller.transactionType.value =
        value == TransferFilterType.walletTransfer
            ? "Wallet Transfer"
            : "Wallet Reverse";

    // API call
    controller.getWalletTransferDetail(
      search: controller.search.value,
      startDate: controller.fromDate,
      endDate: controller.toDate,
      transferType: controller.transactionType.value,
    );
  },
  onSearchChanged: (value) {
    controller.search.value = value;

    controller.getWalletTransferDetail(
      search: value,
      startDate: controller.fromDate,
      endDate: controller.toDate,
      transferType: controller.transactionType.value,
    );
  },
),

            const SizedBox(height: 16),

           
           if (_selectedFilter != null) ...[
  Obx(() => TransferSummaryCard(
        filterType: controller.selectedFilter.value,
        amount: controller.totalAmount.value,
      )),
  const SizedBox(height: 16),
],

            Divider(color: AppColors.darktextclr.withValues(alpha: 0.5)),

            const SizedBox(height: 16),

           Expanded(
  child: Obx(() {

    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

   if (controller.transferList.isEmpty) {
      return const Center(
        child: Text("No Transactions Found"),
      );
    }

    return ListView.builder(
      itemCount: controller.transferList.length,
      itemBuilder: (context, index) {

  final item = controller.transferList[index];

        return TransactionCard(
          transaction: WalletTransaction(
             id: item.id ?? 0,
            transactionId: item.txnId ?? "",
            dateTime: DateTime.parse(item.createdAt ?? ""),
          type: item.paymentType == "Wallet Reverse"
    ? TransferFilterType.reverse
    : TransferFilterType.walletTransfer,
            userType: item.userType ?? "",
            userName: item.name ?? "",
            regMobNo: item.mobileNumber ?? "",
            amount: double.tryParse(item.amount ?? "0") ?? 0,
          ),
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