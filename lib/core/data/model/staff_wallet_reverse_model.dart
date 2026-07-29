class StaffReverse {
  bool? success;
  Data? data;
  String? message;
  int? code;

  StaffReverse({this.success, this.data, this.message, this.code});

  StaffReverse.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['retailer_id'] = retailerId;
    data['staff_id'] = staffId;
    data['payment_type'] = paymentType;
    data['amount'] = amount;
    data['txn_id'] = txnId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
