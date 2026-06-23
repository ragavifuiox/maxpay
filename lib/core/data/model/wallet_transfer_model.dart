class walletTransfer {
  bool? success;
  TransferData? data;
  String? message;
  int? code;

  walletTransfer({this.success, this.data, this.message, this.code});

  walletTransfer.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? TransferData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class TransferData {
  String? transactionId;
  String? retailerId;
  String? staffId;
  String? paymentType;
  String? amount;
  String? retailerBalance;
  String? staffBalance;
  String? createdAt;

  TransferData(
      {this.transactionId,
      this.retailerId,
      this.staffId,
      this.paymentType,
      this.amount,
      this.retailerBalance,
      this.staffBalance,
      this.createdAt});

  TransferData.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    retailerId = json['retailer_id'];
    staffId = json['staff_id'];
    paymentType = json['payment_type'];
    amount = json['amount'];
    retailerBalance = json['retailer_balance'];
    staffBalance = json['staff_balance'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['retailer_id'] = retailerId;
    data['staff_id'] = staffId;
    data['payment_type'] = paymentType;
    data['amount'] = amount;
    data['retailer_balance'] = retailerBalance;
    data['staff_balance'] = staffBalance;
    data['created_at'] = createdAt;
    return data;
  }
}
