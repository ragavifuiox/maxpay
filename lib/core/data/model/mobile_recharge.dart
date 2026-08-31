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
    code = json['code'] != null ? int.tryParse(json['code'].toString()) : null;
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
  String? refId;

  Data({this.recharge, this.apiResponse, this.refId});

  Data.fromJson(Map<String, dynamic> json) {
    recharge = json['recharge'] != null
        ? Recharge.fromJson(json['recharge'])
        : null;

    refId = json['refid']?.toString();

    apiResponse = json['api_response'] != null
        ? ApiResponse.fromJson(json['api_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (recharge != null) {
      data['recharge'] = recharge!.toJson();
    }

    data['refid'] = refId;

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
  String? txnId;
  String? refid;
  String? transactionid;
  String? requestTime;
  String? paymentStatus;
  String? whatsappNo;
  String? createdAt;
  String? updatedAt;

  Recharge({
    this.id,
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
    this.refid,
    this.transactionid,
    this.requestTime,
    this.paymentStatus,
    this.whatsappNo,
    this.createdAt,
    this.updatedAt,
  });

  Recharge.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    userId = json['user_id']?.toString();
    userName = json['user_name']?.toString();
    productId = json['product_id'] != null
        ? int.tryParse(json['product_id'].toString())
        : null;
    apiId = json['api_id'] != null
        ? int.tryParse(json['api_id'].toString())
        : null;
    mappingId = json['mapping_id'] != null
        ? int.tryParse(json['mapping_id'].toString())
        : null;
    mobile = json['mobile']?.toString();
    amount = json['amount']?.toString();
    status = json['status']?.toString();
    apiResponse = json['api_response']?.toString();
    userType = json['user_type']?.toString();
    time = json['time']?.toString();
    txnId = json['txn_id']?.toString();
    refid = json['ref_id']?.toString();
    transactionid = json['transaction_id']?.toString();
    requestTime = json['request_time']?.toString();
    paymentStatus = json['payment_status']?.toString();
    whatsappNo = json['whatsapp_no']?.toString();
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
    data['txn_id'] = txnId;
    data['txn_id'] = txnId;
    data['ref_id'] = refid;
    data['transaction_id'] = transactionid;
    data['request_time'] = requestTime;
    data['payment_status'] = paymentStatus;
    data['whatsapp_no'] = whatsappNo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ApiResponse {
  ApiData? data;
  String? logo;

  ApiResponse({this.data, this.logo});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ApiData.fromJson(json['data']) : null;
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['logo'] = logo;
    return data;
  }
}

class ApiData {
  int? orderId;
  String? status;
  String? optid;
  String? urid;
  int? resCode;
  String? resText;

  ApiData({
    this.orderId,
    this.status,
    this.optid,
    this.urid,
    this.resCode,
    this.resText,
  });

  ApiData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'] != null
        ? int.tryParse(json['orderId'].toString())
        : null;
    status = json['status']?.toString();
    optid = json['optid']?.toString();
    urid = json['urid']?.toString();
    resCode = json['resCode'] != null
        ? int.tryParse(json['resCode'].toString())
        : null;
    resText = json['resText']?.toString();

    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['status'] = status;
    data['optid'] = optid;
    data['urid'] = urid;
    data['resCode'] = resCode;
    data['resText'] = resText;
    return data;
  }
}
