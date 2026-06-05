class TransConfirm {
  bool? success;
  ConfirmData? data;
  String? message;
  int? code;

  TransConfirm({this.success, this.data, this.message, this.code});

  TransConfirm.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ConfirmData.fromJson(json['data']) : null;
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

class ConfirmData {
  String? planId;
  int? productId;
  String? productName;
  String? amount;
  String? planDetails;
  String? paymentStatus;
  String? transactionNo;
  int? availableBalance;
  String? transactionAmount;
  String? commision;
  int? remainingBalance;
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
    availableBalance = json['available_balance'];
    transactionAmount = json['transaction_amount'];
    commision = json['commision'];
    remainingBalance = json['remaining_balance'];
    logo = json['product_logp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_id'] = this.planId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['amount'] = this.amount;
    data['plan_details'] = this.planDetails;
    data['payment_status'] = this.paymentStatus;
    data['transaction_no'] = this.transactionNo;
    data['available_balance'] = this.availableBalance;
    data['transaction_amount'] = this.transactionAmount;
    data['commision'] = this.commision;
    data['remaining_balance'] = this.remainingBalance;
    data['product_logp'] = this.logo;
    return data;
  }
}
