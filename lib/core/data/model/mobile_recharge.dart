class MobileRecharge {
  bool? success;
  Data? data;
  String? message;
  int? code;

  MobileRecharge({this.success, this.data, this.message, this.code});

  MobileRecharge.fromJson(Map<String, dynamic> json) {
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
  Recharge? recharge;
  ApiResponse? apiResponse;

  Data({this.recharge, this.apiResponse});

  Data.fromJson(Map<String, dynamic> json) {
    recharge = json['recharge'] != null
        ? new Recharge.fromJson(json['recharge'])
        : null;
   apiResponse =
    (json['api_response'] != null &&
     json['api_response'] is Map<String, dynamic>)
        ? ApiResponse.fromJson(json['api_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recharge != null) {
      data['recharge'] = this.recharge!.toJson();
    }
    if (this.apiResponse != null) {
      data['api_response'] = this.apiResponse!.toJson();
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
  String? requestTime;
  String? createdAt;
  String? updatedAt;
  String? logo;

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
      this.requestTime,
      this.createdAt,
      this.updatedAt,});

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
    requestTime = json['request_time'];
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
    data['request_time'] = this.requestTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ApiResponse {
  String? txnid;
  String? status;
  String? mobileno;
  String? amount;
  String? operatorcode;
  String? operatorName;
  String? requestDatetime;
  String? refid;
  String? operatorid;
  String? message;
  double? remainamount;
  String? logo;

  ApiResponse(
      {this.txnid,
      this.status,
      this.mobileno,
      this.amount,
      this.operatorcode,
      this.operatorName,
      this.requestDatetime,
      this.refid,
      this.operatorid,
      this.message,
      this.remainamount,
      this.logo});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    txnid = json['txnid'];
    status = json['status'];
    mobileno = json['mobileno'];
    amount = json['amount'];
    operatorcode = json['operatorcode'];
    operatorName = json['operator_name'];
    requestDatetime = json['request_datetime'];
    refid = json['refid'];
    operatorid = json['operatorid'];
    message = json['message'];
    remainamount = json['remainamount'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txnid'] = this.txnid;
    data['status'] = this.status;
    data['mobileno'] = this.mobileno;
    data['amount'] = this.amount;
    data['operatorcode'] = this.operatorcode;
    data['operator_name'] = this.operatorName;
    data['request_datetime'] = this.requestDatetime;
    data['refid'] = this.refid;
    data['operatorid'] = this.operatorid;
    data['message'] = this.message;
    data['remainamount'] = this.remainamount;
    data['logo'] = this.logo;
    return data;
  }
}
