class ElectricityConfirmModel {
  bool? success;
  ElectricityConfirmData? data;
  String? message;
  int? code;

  ElectricityConfirmModel({this.success, this.data, this.message, this.code});

  ElectricityConfirmModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? ElectricityConfirmData.fromJson(json['data'])
        : null;
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

class ElectricityConfirmData {
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
  String? logo;
  String? commissiontype;

  ElectricityConfirmData({
    this.planId,
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
    this.logo,
    this.commissiontype,
  });

  ElectricityConfirmData.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id']?.toString();
    productId = json['product_id'];
    productName = json['product_name']?.toString();
    amount = json['amount']?.toString();
    planDetails = json['plan_details']?.toString();
    paymentStatus = json['payment_status']?.toString();
    transactionNo = json['transaction_no']?.toString();

    transactionAmount = json['transaction_amount']?.toString();
    commision = json['commision']?.toString();
    availableBalance = json['available_balance']?.toString();
    remainingBalance = json['remaining_balance']?.toString();
    logo = json['logo']?.toString();
    commissiontype = json['commissiontype']?.toString();
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
    data['transaction_amount'] = transactionAmount;
    data['commision'] = commision;
    data['available_balance'] = availableBalance;
    data['remaining_balance'] = remainingBalance;
    data['logo'] = logo;
    data['commissiontype'] = commissiontype;
    return data;
  }
}
