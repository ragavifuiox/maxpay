class TotalTransaction {
  bool? success;
  Data? data;
  String? message;
  int? code;

  TotalTransaction({this.success, this.data, this.message, this.code});

  TotalTransaction.fromJson(Map<String, dynamic> json) {
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
  String? totalAmount;
  String? successAmount;
  String? pendingAmount;
  String? failedAmount;

  Data(
      {this.totalAmount,
      this.successAmount,
      this.pendingAmount,
      this.failedAmount});

  Data.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    successAmount = json['success_amount'];
    pendingAmount = json['pending_amount'];
    failedAmount = json['failed_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_amount'] = totalAmount;
    data['success_amount'] = successAmount;
    data['pending_amount'] = pendingAmount;
    data['failed_amount'] = failedAmount;
    return data;
  }
}
