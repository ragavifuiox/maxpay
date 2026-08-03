class DthRecharge {
  String? status;
  String? message;
  int? transactionId;
  RechargeResponse? data;

  DthRecharge({this.status, this.message, this.transactionId, this.data});

  DthRecharge.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    transactionId = json['transaction_id'];

    if (json['response'] != null) {
      // The backend returns it inside "response"
      data = RechargeResponse.fromJson({"data": json['response']});
    } else if (json['data'] != null) {
      data = RechargeResponse.fromJson(json['data']);
    } else {
      data = null;
    }
  }
}

class RechargeResponse {
  String? status;
  String? response;
  RechargeDetails? data;
  dynamic error;

  RechargeResponse({this.status, this.response, this.data, this.error});

  RechargeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    data = json['data'] != null ? RechargeDetails.fromJson(json['data']) : null;
    error = json['error'];
  }
}

class RechargeDetails {
  String? tnxId;
  String? status;
  String? mobileno;
  String? amount;
  String? operatorcode;
  String? operatorName;
  String? rechargeDate;
  String? refid;
  String? operatorid;
  String? message;
  double? remainamount;

  RechargeDetails({
    this.tnxId,
    this.status,
    this.mobileno,
    this.amount,
    this.operatorcode,
    this.operatorName,
    this.rechargeDate,
    this.refid,
    this.operatorid,
    this.message,
    this.remainamount,
  });

  RechargeDetails.fromJson(Map<String, dynamic> json) {
    tnxId = json['txnid'] ?? json['tnx_id'];

    status = json['status'];
    mobileno = json['mobileno'];
    amount = json['amount']?.toString();
    operatorcode = json['operatorcode'];
    operatorName = json['operator_name'];
    rechargeDate = json['request_datetime'] ?? json['recharge_date'];
    refid = json['refid'];
    operatorid = json['operatorid'];
    message = json['message'];
    remainamount = (json['remainamount'] as num?)?.toDouble();
  }
}
