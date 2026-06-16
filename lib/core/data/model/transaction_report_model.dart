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
        data!.add(TransrepData.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['operator'] = operator;
    data['mobile'] = mobile;
    data['amount'] = amount;
    data['status'] = status;
    data['date_time'] = dateTime;
    data['logo'] = logo;
    return data;
  }
}
