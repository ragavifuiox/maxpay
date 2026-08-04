class ConfirmDth {
  bool? success;
  Data? data;
  String? message;
  int? code;

  ConfirmDth({this.success, this.data, this.message, this.code});

  ConfirmDth.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? productId;
  String? productName;
  String? paymentStatus;
  String? transactionNo;
  String? availableBalance;
  String? transactionAmount;
  String? commission;
  String? remainingBalance;
  String? logo;
  String? commissiontype;

  Data({
    this.productId,
    this.productName,
    this.paymentStatus,
    this.transactionNo,
    this.availableBalance,
    this.transactionAmount,
    this.commission,
    this.remainingBalance,
    this.logo,
    this.commissiontype,
  });

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    paymentStatus = json['payment_status'];
    transactionNo = json['transaction_no'];
    availableBalance = json['available_balance']?.toString();
    transactionAmount = json['transaction_amount']?.toString();
    commission = (json['commission'] ?? json['commision'])?.toString();
    remainingBalance = json['remaining_balance']?.toString();
    logo = json['product_logo'];
    commissiontype = (json['commission_type'] ?? json['commision_type'])
        ?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['payment_status'] = paymentStatus;
    data['transaction_no'] = transactionNo;
    data['available_balance'] = availableBalance;
    data['transaction_amount'] = transactionAmount;
    data['commission'] = commission;
    data['remaining_balance'] = remainingBalance;
    data['product_logo'] = logo;
    data['commission_type'] = commissiontype;
    return data;
  }
}
