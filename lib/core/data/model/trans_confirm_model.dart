class TransConfirm {
  bool? success;
  ConfirmData? data;
  String? message;
  int? code;

  TransConfirm({this.success, this.data, this.message, this.code});

  TransConfirm.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ConfirmData.fromJson(json['data']) : null;
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

class ConfirmData {
  String? planId;
  int? productId;
  String? productName;
  String? amount;
  String? planDetails;
  String? paymentStatus;
  String? transactionNo;

  String? transactionAmount;
  String? commision;
String? availableBalance;
String? remainingBalance;
  String?logo;

  ConfirmData(
      {this.planId,
      this.productId,
      this.productName,
      this.amount,
      this.planDetails,
      this.paymentStatus,
      this.transactionNo,
      this.availableBalance,
      this.transactionAmount,
      this.commision,
      this.remainingBalance,
      this.logo});

  ConfirmData.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    amount = json['amount'];
    planDetails = json['plan_details'];
    paymentStatus = json['payment_status'];
    transactionNo = json['transaction_no'];
    availableBalance = json['available_balance']?.toString();
remainingBalance = json['remaining_balance']?.toString();
    transactionAmount = json['transaction_amount'];
    commision = json['commision'];
    // remainingBalance = json['remaining_balance'];
    logo = json['product_logp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan_id'] = planId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['amount'] = amount;
    data['plan_details'] = planDetails;
    data['payment_status'] = paymentStatus;
    data['transaction_no'] = transactionNo;
    data['available_balance'] = availableBalance;
    data['transaction_amount'] = transactionAmount;
    data['commision'] = commision;
    data['remaining_balance'] = remainingBalance;
    data['product_logp'] = logo;
    return data;
  }
}
