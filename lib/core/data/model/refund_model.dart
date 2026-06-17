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
        data!.add(new RefundData.fromJson(v));  
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operator_name'] = this.operatorName;
    data['operator_logo'] = this.operatorLogo;
    data['transaction_no'] = this.transactionNo;
    data['amount'] = this.amount;
    data['date_time'] = this.dateTime;
    return data;
  }
}
