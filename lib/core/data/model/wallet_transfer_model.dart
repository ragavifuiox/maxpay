class walletTransfer {
  bool? success;
  TransferData? data;
  String? message;
  int? code;

  walletTransfer({this.success, this.data, this.message, this.code});

  walletTransfer.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new TransferData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['retailer_id'] = this.retailerId;
    data['staff_id'] = this.staffId;
    data['payment_type'] = this.paymentType;
    data['amount'] = this.amount;
    data['retailer_balance'] = this.retailerBalance;
    data['staff_balance'] = this.staffBalance;
    data['created_at'] = this.createdAt;
    return data;
  }
}
