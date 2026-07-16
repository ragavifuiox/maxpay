class StaffReverse {
  bool? success;
  Data? data;
  String? message;
  int? code;

  StaffReverse({this.success, this.data, this.message, this.code});

  StaffReverse.fromJson(Map<String, dynamic> json) {
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
  String? retailerId;
  String? staffId;
  String? paymentType;
  String? amount;
  String? txnId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.retailerId,
      this.staffId,
      this.paymentType,
      this.amount,
      this.txnId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    retailerId = json['retailer_id'];
    staffId = json['staff_id'];
    paymentType = json['payment_type'];
    amount = json['amount'];
    txnId = json['txn_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['retailer_id'] = this.retailerId;
    data['staff_id'] = this.staffId;
    data['payment_type'] = this.paymentType;
    data['amount'] = this.amount;
    data['txn_id'] = this.txnId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
