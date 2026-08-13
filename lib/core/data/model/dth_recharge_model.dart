class DthRecharge {
  String? status;
  String? message;
  int? transactionId;
  TransactionDetails? transactionDetails;
  Response? response;
  String? rawResponse;
  ApiLog? apiLog;

  DthRecharge({
    this.status,
    this.message,
    this.transactionId,
    this.transactionDetails,
    this.response,
    this.rawResponse,
    this.apiLog,
  });

  DthRecharge.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    transactionId = int.tryParse(json['transaction_id']?.toString() ?? '');
    transactionDetails = json['transaction_details'] != null
        ? new TransactionDetails.fromJson(json['transaction_details'])
        : null;
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    rawResponse = json['raw_response']?.toString();
    apiLog = json['api_log'] != null
        ? new ApiLog.fromJson(json['api_log'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['transaction_id'] = this.transactionId;
    if (this.transactionDetails != null) {
      data['transaction_details'] = this.transactionDetails!.toJson();
    }
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['raw_response'] = this.rawResponse;
    if (this.apiLog != null) {
      data['api_log'] = this.apiLog!.toJson();
    }
    return data;
  }
}

class TransactionDetails {
  String? txnId;
  String? referenceId;
  String? operatorId;
  String? transactionDatetime;
  String? status;
  String? message;
  String? refid;

  TransactionDetails({
    this.txnId,
    this.referenceId,
    this.operatorId,
    this.transactionDatetime,
    this.status,
    this.message,
    this.refid,
  });

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    txnId = json['txn_id']?.toString();
    referenceId = json['ref_id']?.toString();
    operatorId = json['operator_id']?.toString();
    transactionDatetime = json['transaction_datetime']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    refid = json['ref_id']?.toString() ?? json['ref_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txn_id'] = this.txnId;
    data['ref_id'] = this.referenceId;
    data['operator_id'] = this.operatorId;
    data['transaction_datetime'] = this.transactionDatetime;
    data['status'] = this.status;
    data['message'] = this.message;
    data['ref_id'] = this.refid;
    return data;
  }
}

class Response {
  String? lapuNo;
  double? balance;
  int? roffer;
  String? status;
  String? rechargeDate;
  int? id;
  int? lapuId;
  int? userId;
  int? companyId;
  String? mobileNo;
  int? amount;
  String? orderId;
  String? ipAddress;
  String? updatedAt;
  String? createdAt;
  String? response;
  String? tnxId;

  Response({
    this.lapuNo,
    this.balance,
    this.roffer,
    this.status,
    this.rechargeDate,
    this.id,
    this.lapuId,
    this.userId,
    this.companyId,
    this.mobileNo,
    this.amount,
    this.orderId,
    this.ipAddress,
    this.updatedAt,
    this.createdAt,
    this.response,
    this.tnxId,
  });

  Response.fromJson(Map<String, dynamic> json) {
    lapuNo = json['lapu_no']?.toString();
    balance = double.tryParse(json['balance']?.toString() ?? '');
    roffer = int.tryParse(json['roffer']?.toString() ?? '');
    status = json['status']?.toString();
    rechargeDate = json['recharge_date']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    lapuId = int.tryParse(json['lapu_id']?.toString() ?? '');
    userId = int.tryParse(json['user_id']?.toString() ?? '');
    companyId = int.tryParse(json['company_id']?.toString() ?? '');
    mobileNo = json['mobile_no']?.toString();
    amount = int.tryParse(json['amount']?.toString() ?? '');
    orderId = json['order_id']?.toString();
    ipAddress = json['ip_address']?.toString();
    updatedAt = json['updatedAt']?.toString();
    createdAt = json['createdAt']?.toString();
    response = json['response']?.toString();
    tnxId = json['tnx_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lapu_no'] = this.lapuNo;
    data['balance'] = this.balance;
    data['roffer'] = this.roffer;
    data['status'] = this.status;
    data['recharge_date'] = this.rechargeDate;
    data['id'] = this.id;
    data['lapu_id'] = this.lapuId;
    data['user_id'] = this.userId;
    data['company_id'] = this.companyId;
    data['mobile_no'] = this.mobileNo;
    data['amount'] = this.amount;
    data['order_id'] = this.orderId;
    data['ip_address'] = this.ipAddress;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['response'] = this.response;
    data['tnx_id'] = this.tnxId;
    return data;
  }
}

class ApiLog {
  int? priority;
  int? apiId;
  String? apiName;
  String? status;
  String? mobile;
  int? amount;
  String? productCode;
  Response? response;
  String? rawResponse;
  dynamic error;

  ApiLog({
    this.priority,
    this.apiId,
    this.apiName,
    this.status,
    this.mobile,
    this.amount,
    this.productCode,
    this.response,
    this.rawResponse,
    this.error,
  });

  ApiLog.fromJson(Map<String, dynamic> json) {
    priority = int.tryParse(json['priority']?.toString() ?? '');
    apiId = int.tryParse(json['api_id']?.toString() ?? '');
    apiName = json['api_name']?.toString();
    status = json['status']?.toString();
    mobile = json['mobile']?.toString();
    amount = int.tryParse(json['amount']?.toString() ?? '');
    productCode = json['product_code']?.toString();
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    rawResponse = json['raw_response']?.toString();
    error = json['error']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['priority'] = this.priority;
    data['api_id'] = this.apiId;
    data['api_name'] = this.apiName;
    data['status'] = this.status;
    data['mobile'] = this.mobile;
    data['amount'] = this.amount;
    data['product_code'] = this.productCode;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['raw_response'] = this.rawResponse;
    data['error'] = this.error;
    return data;
  }
}
