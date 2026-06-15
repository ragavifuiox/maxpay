class ConfirmDth {
  bool? success;
  Data? data;
  String? message;
  int? code;

  ConfirmDth({this.success, this.data, this.message, this.code});

  ConfirmDth.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? productId;
  String? productName;
  String? paymentStatus;
  String? transactionNo;
  String? availableBalance;
  String? transactionAmount;
  String? commission;
  String? remainingBalance;
  String?logo;

  Data(
      {this.productId,
      this.productName,
      this.paymentStatus,
      this.transactionNo,
      this.availableBalance,
      this.transactionAmount,
      this.commission,
      this.remainingBalance,
      this.logo});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    paymentStatus = json['payment_status'];
    transactionNo = json['transaction_no'];
    availableBalance = json['available_balance'];
    transactionAmount = json['transaction_amount'];
    commission = json['commission'];
    remainingBalance = json['remaining_balance'];
    logo = json['product_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['payment_status'] = this.paymentStatus;
    data['transaction_no'] = this.transactionNo;
    data['available_balance'] = this.availableBalance;
    data['transaction_amount'] = this.transactionAmount;
    data['commission'] = this.commission;
    data['remaining_balance'] = this.remainingBalance;
    data['product_logo'] = this.logo;
    return data;
  }
}
