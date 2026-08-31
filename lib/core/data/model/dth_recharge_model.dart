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
        ? TransactionDetails.fromJson(json['transaction_details'])
        : null;
    response = json['response'] != null
        ? Response.fromJson(json['response'])
        : null;
    rawResponse = json['raw_response']?.toString();
    apiLog = json['api_log'] != null
        ? ApiLog.fromJson(json['api_log'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['transaction_id'] = transactionId;
    if (transactionDetails != null) {
      data['transaction_details'] = transactionDetails!.toJson();
    }
    if (response != null) {
      data['response'] = response!.toJson();
    }
    data['raw_response'] = rawResponse;
    if (apiLog != null) {
      data['api_log'] = apiLog!.toJson();
    }
    return data;
  }
}

class TransactionDetails {
  String? txnId;
  String? referenceId;
  String? operatorId;
  String? transactionId;
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
    this.transactionId,
  });

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    txnId = json['txn_id']?.toString();
    referenceId = json['ref_id']?.toString();
    operatorId = json['operator_id']?.toString();
    transactionId = json['transaction_id']?.toString();
    transactionDatetime = json['transaction_datetime']?.toString();
    status = json['status']?.toString();
    message = json['message']?.toString();
    refid = json['ref_id']?.toString() ?? json['ref_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['txn_id'] = txnId;
    data['ref_id'] = referenceId;
    data['operator_id'] = operatorId;
    data['transaction_id'] = transactionId;
    data['transaction_datetime'] = transactionDatetime;
    data['status'] = status;
    data['message'] = message;
    data['ref_id'] = refid;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lapu_no'] = lapuNo;
    data['balance'] = balance;
    data['roffer'] = roffer;
    data['status'] = status;
    data['recharge_date'] = rechargeDate;
    data['id'] = id;
    data['lapu_id'] = lapuId;
    data['user_id'] = userId;
    data['company_id'] = companyId;
    data['mobile_no'] = mobileNo;
    data['amount'] = amount;
    data['order_id'] = orderId;
    data['ip_address'] = ipAddress;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['response'] = response;
    data['tnx_id'] = tnxId;
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
        ? Response.fromJson(json['response'])
        : null;
    rawResponse = json['raw_response']?.toString();
    error = json['error']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['priority'] = priority;
    data['api_id'] = apiId;
    data['api_name'] = apiName;
    data['status'] = status;
    data['mobile'] = mobile;
    data['amount'] = amount;
    data['product_code'] = productCode;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    data['raw_response'] = rawResponse;
    data['error'] = error;
    return data;
  }
}
