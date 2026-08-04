class TotalTransaction {
  bool? success;
  Data? data;
  String? message;
  int? code;

  TotalTransaction({this.success, this.data, this.message, this.code});

  TotalTransaction.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount'] = this.totalAmount;
    data['success_amount'] = this.successAmount;
    data['pending_amount'] = this.pendingAmount;
    data['failed_amount'] = this.failedAmount;
    return data;
  }
}
