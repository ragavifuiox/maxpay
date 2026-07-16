/// Filter / transaction type shown in the dropdown.
enum TransferFilterType {
  reverse,
  walletTransfer,
}

extension TransferFilterTypeLabel on TransferFilterType {
  String get label {
    switch (this) {
      case TransferFilterType.reverse:
        return 'Wallet Reverse';

      case TransferFilterType.walletTransfer:
        return 'Wallet Transfer';
    }
  }
}

class WalletTransaction {
  final String transactionId;
  final DateTime dateTime;
  final TransferFilterType type;
  final String userType;
  final String userName;
  final String regMobNo;
  final double amount;
  final int id; 
  const WalletTransaction({
        required this.id,
    required this.transactionId,
    required this.dateTime,
    required this.type,
    required this.userType,
    required this.userName,
    required this.regMobNo,
    required this.amount,
  });
}