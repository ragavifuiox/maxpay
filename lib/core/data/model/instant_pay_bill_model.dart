class InstantPayBill {
  bool? success;
  Data? data;
  String? message;
  int? code;

  InstantPayBill({this.success, this.data, this.message, this.code});

  InstantPayBill.fromJson(Map<String, dynamic> json) {
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
  String? status;
  String? txnid;
  String? transactionid;
  int? rechargeId;
  String? billerId;
  String? consumerNumber;
  String? customerMobile;
  String? whatsappNumber;
  String? transactionAmount;
  String? commission;
  String? referenceId;
  String? dateTime;
  String? walletBalance;
  Product? product;

  Data(
      {this.status,
      this.txnid,
      this.rechargeId,
      this.billerId,
      this.consumerNumber,
      this.customerMobile,
      this.whatsappNumber,
      this.transactionAmount,
      this.commission,
      this.referenceId,
      this.dateTime,
      this.walletBalance,
      this.transactionid,
      this.product});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    txnid = json['txnid'];
    transactionid = json['transaction_id'];
    rechargeId = json['recharge_id'];
    billerId = json['biller_id'];
    consumerNumber = json['consumer_number'];
    customerMobile = json['customer_mobile'];
    whatsappNumber = json['whatsapp_number'];
    transactionAmount = json['transaction_amount'];
    commission = json['commission'];
    referenceId = json['reference_id'];
    dateTime = json['date_time'];
    walletBalance = json['wallet_balance'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['txnid'] = this.txnid;
    data['transaction_id'] = this.transactionid;
    data['recharge_id'] = this.rechargeId;
    data['biller_id'] = this.billerId;
    data['consumer_number'] = this.consumerNumber;
    data['customer_mobile'] = this.customerMobile;
    data['whatsapp_number'] = this.whatsappNumber;
    data['transaction_amount'] = this.transactionAmount;
    data['commission'] = this.commission;
    data['reference_id'] = this.referenceId;
    data['date_time'] = this.dateTime;
    data['wallet_balance'] = this.walletBalance;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? logo;

  Product({this.id, this.name, this.logo});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
