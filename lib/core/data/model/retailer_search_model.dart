class RetailorSearch {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  RetailorSearch({this.success, this.data, this.message, this.code});

  RetailorSearch.fromJson(Map<String, dynamic> json) {
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
  String? txnId;
  String? refId;
  String? transactionId;
  String? requestTime;
  String? paymentStatus;
  Null? whatsappNo;
  String? rechargeMode;
  String? createdAt;
  String? updatedAt;

  Data(
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
      this.refId,
      this.transactionId,
      this.requestTime,
      this.paymentStatus,
      this.whatsappNo,
      this.rechargeMode,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    refId = json['ref_id'];
    transactionId = json['transaction_id'];
    requestTime = json['request_time'];
    paymentStatus = json['payment_status'];
    whatsappNo = json['whatsapp_no'];
    rechargeMode = json['recharge_mode'];
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
    data['ref_id'] = this.refId;
    data['transaction_id'] = this.transactionId;
    data['request_time'] = this.requestTime;
    data['payment_status'] = this.paymentStatus;
    data['whatsapp_no'] = this.whatsappNo;
    data['recharge_mode'] = this.rechargeMode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
