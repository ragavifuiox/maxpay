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
    code = json['code'] != null ? int.tryParse(json['code'].toString()) : null;
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
  String? refId;

  Data({this.recharge, this.apiResponse, this.refId});

  Data.fromJson(Map<String, dynamic> json) {
    recharge = json['recharge'] != null
        ? new Recharge.fromJson(json['recharge'])
        : null;

    refId = json['refid']?.toString();

    apiResponse = json['api_response'] != null
        ? new ApiResponse.fromJson(json['api_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.recharge != null) {
      data['recharge'] = this.recharge!.toJson();
    }

    data['refid'] = this.refId;

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
    data['txn_id'] = this.txnId;
    data['ref_id'] = this.refid;
    data['transaction_id'] = this.transactionid;
    data['request_time'] = this.requestTime;
    data['payment_status'] = this.paymentStatus;
    data['whatsapp_no'] = this.whatsappNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ApiResponse {
  ApiData? data;
  String? logo;

  ApiResponse({this.data, this.logo});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ApiData.fromJson(json['data']) : null;
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['logo'] = this.logo;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['status'] = this.status;
    data['optid'] = this.optid;
    data['urid'] = this.urid;
    data['resCode'] = this.resCode;
    data['resText'] = this.resText;
    return data;
  }
}
