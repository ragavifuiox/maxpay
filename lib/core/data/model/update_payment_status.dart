class UpdatePaymentStatus {
  bool? success;
  UpdatePaymentData? data;
  String? message;
  int? code;

  UpdatePaymentStatus({this.success, this.data, this.message, this.code});

  UpdatePaymentStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new UpdatePaymentData.fromJson(json['data']) : null;
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

class UpdatePaymentData {
  String? paymentStatus;
  Recharge? recharge;

  UpdatePaymentData({this.paymentStatus, this.recharge});

  UpdatePaymentData.fromJson(Map<String, dynamic> json) {
    paymentStatus = json['payment_status'];
    recharge = json['recharge'] != null
        ? new Recharge.fromJson(json['recharge'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_status'] = this.paymentStatus;
    if (this.recharge != null) {
      data['recharge'] = this.recharge!.toJson();
    }
    return data;
  }
}

class Recharge {
  int? id;
  String? userId;
  String? userName;
  int? productId;
  int? apiId;
  int? mappingId;
  String? mobile;
  String? amount;
  String? status;
  String? apiResponse;
  String? userType;
  String? time;
  Null? txnId;
  String? requestTime;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;

  Recharge(
      {this.id,
      this.userId,
      this.userName,
      this.productId,
      this.apiId,
      this.mappingId,
      this.mobile,
      this.amount,
      this.status,
      this.apiResponse,
      this.userType,
      this.time,
      this.txnId,
      this.requestTime,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt});

  Recharge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    productId = json['product_id'];
    apiId = json['api_id'];
    mappingId = json['mapping_id'];
    mobile = json['mobile'];
    amount = json['amount'];
    status = json['status'];
    apiResponse = json['api_response'];
    userType = json['user_type'];
    time = json['time'];
    txnId = json['txn_id'];
    requestTime = json['request_time'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['product_id'] = this.productId;
    data['api_id'] = this.apiId;
    data['mapping_id'] = this.mappingId;
    data['mobile'] = this.mobile;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['api_response'] = this.apiResponse;
    data['user_type'] = this.userType;
    data['time'] = this.time;
    data['txn_id'] = this.txnId;
    data['request_time'] = this.requestTime;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
