class Refund {
  bool? success;
  List<RefundData>? data;
  String? message;
  int? code;

  Refund({this.success, this.data, this.message, this.code});

  Refund.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <RefundData>[];
      json['data'].forEach((v) {
        data!.add(RefundData.fromJson(v));  
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class RefundData {
  String? operatorName;
  String? operatorLogo;
  String? transactionNo;
  String? amount;
  String? dateTime;

  RefundData(
      {this.operatorName,
      this.operatorLogo,
      this.transactionNo,
      this.amount,
      this.dateTime});

  RefundData.fromJson(Map<String, dynamic> json) {
    operatorName = json['operator_name'];
    operatorLogo = json['operator_logo'];
    transactionNo = json['transaction_no'];
    amount = json['amount'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['operator_name'] = operatorName;
    data['operator_logo'] = operatorLogo;
    data['transaction_no'] = transactionNo;
    data['amount'] = amount;
    data['date_time'] = dateTime;
    return data;
  }
}
