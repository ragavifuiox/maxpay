class Graph {
  bool? success;
  Data? data;
  String? message;
  int? code;

  Graph({this.success, this.data, this.message, this.code});

  Graph.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
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
  List<String>? labels;
  List<int>? walletCredit;
  List<int>? successRecharge;
  List<int>? failedRecharge;

  Data(
      {this.labels,
      this.walletCredit,
      this.successRecharge,
      this.failedRecharge});

  Data.fromJson(Map<String, dynamic> json) {
    labels = json['labels'].cast<String>();
    walletCredit = json['wallet_credit'].cast<int>();
    successRecharge = json['success_recharge'].cast<int>();
    failedRecharge = json['failed_recharge'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labels'] = this.labels;
    data['wallet_credit'] = this.walletCredit;
    data['success_recharge'] = this.successRecharge;
    data['failed_recharge'] = this.failedRecharge;
    return data;
  }
}
