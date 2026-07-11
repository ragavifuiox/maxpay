class MobileRecharge {
  bool? success;
  Data? data;
  String? message;
  int? code;

  MobileRecharge({this.success, this.data, this.message, this.code});

  MobileRecharge.fromJson(Map<String, dynamic> json) {
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
  Recharge? recharge;
  ApiResponse? apiResponse;

  Data({this.recharge, this.apiResponse});

  Data.fromJson(Map<String, dynamic> json) {
    recharge = json['recharge'] != null
        ? Recharge.fromJson(json['recharge'])
        : null;
   apiResponse =
    (json['api_response'] != null &&
     json['api_response'] is Map<String, dynamic>)
        ? ApiResponse.fromJson(json['api_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recharge != null) {
      data['recharge'] = recharge!.toJson();
    }
    if (apiResponse != null) {
      data['api_response'] = apiResponse!.toJson();
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
  userId = json['user_id']?.toString();
  userName = json['user_name']?.toString();
  productId = json['product_id'];
  apiId = json['api_id'];
  mappingId = json['mapping_id'];
  mobile = json['mobile']?.toString();
  amount = json['amount']?.toString();
  status = json['status']?.toString();
  apiResponse = json['api_response']?.toString();
  userType = json['user_type']?.toString();
  time = json['time']?.toString();
  requestTime = json['request_time']?.toString();
  createdAt = json['created_at']?.toString();
  updatedAt = json['updated_at']?.toString();
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['product_id'] = productId;
    data['api_id'] = apiId;
    data['mapping_id'] = mappingId;
    data['mobile'] = mobile;
    data['amount'] = amount;
    data['status'] = status;
    data['api_response'] = apiResponse;
    data['user_type'] = userType;
    data['time'] = time;
    data['request_time'] = requestTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
  txnid = (json['txnid'] ?? json['tnx_id'])?.toString();
  status = json['status']?.toString();
  mobileno = (json['mobileno'] ?? json['mobile_no'])?.toString();
  amount = json['amount']?.toString();
  operatorcode = json['operatorcode']?.toString();
  operatorName = (json['operator_name'] ?? json['operatorName'])?.toString();
  requestDatetime =
      (json['request_datetime'] ??
       json['createdAt'] ??
       json['recharge_date'])?.toString();
  refid = json['refid']?.toString();
  operatorid = json['operatorid']?.toString();
  message = (json['message'] ?? json['response'])?.toString();

  remainamount = json['remainamount'] != null
      ? double.tryParse(json['remainamount'].toString())
      : null;

  logo = json['logo']?.toString();
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['txnid'] = txnid;
    data['status'] = status;
    data['mobileno'] = mobileno;
    data['amount'] = amount;
    data['operatorcode'] = operatorcode;
    data['operator_name'] = operatorName;
    data['request_datetime'] = requestDatetime;
    data['refid'] = refid;
    data['operatorid'] = operatorid;
    data['message'] = message;
    data['remainamount'] = remainamount;
    data['logo'] = logo;
    return data;
  }
}
