class TransactionReport {
  bool? success;
  List<TransrepData>? data;
  String? message;
  int? code;

  TransactionReport({this.success, this.data, this.message, this.code});

  TransactionReport.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TransrepData>[];
      json['data'].forEach((v) {
        data!.add(new TransrepData.fromJson(v));
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

class TransrepData {
  String? transactionId;
  String? operator;
  String? mobile;
  String? amount;
  String? status;
  String? dateTime;
  String? logo;

  TransrepData(
      {this.transactionId,
      this.operator,
      this.mobile,
      this.amount,
      this.status,
      this.dateTime,
      this.logo});

  TransrepData.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    operator = json['operator'];
    mobile = json['mobile'];
    amount = json['amount'];
    status = json['status'];
    dateTime = json['date_time'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['operator'] = this.operator;
    data['mobile'] = this.mobile;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['date_time'] = this.dateTime;
    data['logo'] = this.logo;
    return data;
  }
}
