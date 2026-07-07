class DthRecharge {
  String? status;
  String? message;
  int? transactionId;
  RechargeResponse? data;

  DthRecharge({
    this.status,
    this.message,
    this.transactionId,
    this.data,
  });

  DthRecharge.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    transactionId = json['transaction_id'];
    data = json['data'] != null
        ? RechargeResponse.fromJson(json['data'])
        : null;
  }
}
class RechargeResponse {
  String? status;
  String? response;
  RechargeDetails? data;
  dynamic error;

  RechargeResponse({
    this.status,
    this.response,
    this.data,
    this.error,
  });

  RechargeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    data = json['data'] != null
        ? RechargeDetails.fromJson(json['data'])
        : null;
    error = json['error'];
  }
}
class RechargeDetails {
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

  RechargeDetails({
    this.txnid,
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
  });

  RechargeDetails.fromJson(Map<String, dynamic> json) {
    txnid = json['txnid'];
    status = json['status'];
    mobileno = json['mobileno'];
    amount = json['amount']?.toString();
    operatorcode = json['operatorcode'];
    operatorName = json['operator_name'];
    requestDatetime = json['request_datetime'];
    refid = json['refid'];
    operatorid = json['operatorid'];
    message = json['message'];
    remainamount = (json['remainamount'] as num?)?.toDouble();
  }
}