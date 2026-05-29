class PaymentStatus {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  PaymentStatus({this.success, this.data, this.message, this.code});

  PaymentStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  int? id;
  int? retailerId;
  String? retailerUserId;
  int? bankId;
  String? userType;
  String? paymentFor;
  String? outstandingAmount;
  String? requestAmount;
  String? paymentType;
  Null? bankName;
  String? refNumber;
  String? receipt;
  String? description;
  String? remark;
  String? txnId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.retailerId,
      this.retailerUserId,
      this.bankId,
      this.userType,
      this.paymentFor,
      this.outstandingAmount,
      this.requestAmount,
      this.paymentType,
      this.bankName,
      this.refNumber,
      this.receipt,
      this.description,
      this.remark,
      this.txnId,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerId = json['retailer_id'];
    retailerUserId = json['retailer_user_id'];
    bankId = json['bank_id'];
    userType = json['user_type'];
    paymentFor = json['payment_for'];
    outstandingAmount = json['outstanding_amount'];
    requestAmount = json['request_amount'];
    paymentType = json['payment_type'];
    bankName = json['bank_name'];
    refNumber = json['ref_number'];
    receipt = json['receipt'];
    description = json['description'];
    remark = json['remark'];
    txnId = json['txn_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['retailer_id'] = this.retailerId;
    data['retailer_user_id'] = this.retailerUserId;
    data['bank_id'] = this.bankId;
    data['user_type'] = this.userType;
    data['payment_for'] = this.paymentFor;
    data['outstanding_amount'] = this.outstandingAmount;
    data['request_amount'] = this.requestAmount;
    data['payment_type'] = this.paymentType;
    data['bank_name'] = this.bankName;
    data['ref_number'] = this.refNumber;
    data['receipt'] = this.receipt;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['txn_id'] = this.txnId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
