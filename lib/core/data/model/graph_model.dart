class Graph {
  bool? success;
  Data? data;
  String? message;
  int? code;

  Graph({this.success, this.data, this.message, this.code});

  Graph.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] = code;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['labels'] = labels;
    data['wallet_credit'] = walletCredit;
    data['success_recharge'] = successRecharge;
    data['failed_recharge'] = failedRecharge;
    return data;
  }
}
