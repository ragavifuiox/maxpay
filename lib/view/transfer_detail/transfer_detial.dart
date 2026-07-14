import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
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
  String _searchQuery = "";

  // TODO: Replace this with data from your API / repository.
  final List<WalletTransaction> _allTransactions = [
    WalletTransaction(
      transactionId: "TXN6453564",
      dateTime: DateTime(2026, 11, 29, 14, 38, 43),
      type: TransferFilterType.reverse,
      userType: "Retailer",
      userName: "John",
      regMobNo: "9087654321",
      amount: 500.00,
    ),
    WalletTransaction(
      transactionId: "TXN6453564",
      dateTime: DateTime(2026, 11, 29, 14, 38, 43),
      type: TransferFilterType.reverse,
      userType: "Retailer",
      userName: "John",
      regMobNo: "9087654321",
      amount: 500.00,
    ),
    WalletTransaction(
      transactionId: "TXN6453565",
      dateTime: DateTime(2026, 11, 29, 15, 10, 12),
      type: TransferFilterType.walletTransfer,
      userType: "Retailer",
      userName: "John",
      regMobNo: "9087654321",
      amount: 500.00,
    ),
  ];

  /// Applies both the dropdown filter and the search text.
  List<WalletTransaction> get _filteredTransactions {
    return _allTransactions.where((t) {
      final matchesFilter =
          _selectedFilter == null || t.type == _selectedFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          t.transactionId.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.userName.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  double get _totalAmount =>
      _filteredTransactions.fold(0.0, (sum, t) => sum + t.amount);

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
                setState(() => _selectedFilter = value);
              },
              onSearchChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),

            const SizedBox(height: 16),

           
            if (_selectedFilter != null) ...[
              TransferSummaryCard(
                filterType: _selectedFilter,
                amount: _totalAmount,
              ),
              const SizedBox(height: 16),
            ],

            Divider(color: AppColors.darktextclr.withValues(alpha: 0.5)),

            const SizedBox(height: 16),

            /// 🔹 List — automatically re-filters whenever _selectedFilter
            /// or _searchQuery changes, because it reads from the getter.
            Expanded(
              child: _filteredTransactions.isEmpty
                  ? Center(
                      child: Text(
                        "No transactions found",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredTransactions.length,
                      itemBuilder: (context, index) {
                        return TransactionCard(
                          transaction: _filteredTransactions[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}