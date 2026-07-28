class TodayTransaction {
  bool? success;
  Data? data;
  String? message;
  int? code;

  TodayTransaction({this.success, this.data, this.message, this.code});

  TodayTransaction.fromJson(Map<String, dynamic> json) {
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
  int? successAmount;
  int? failedAmount;
  int? processingAmount;

  Data({this.successAmount, this.failedAmount, this.processingAmount});

  Data.fromJson(Map<String, dynamic> json) {
    successAmount = json['success_amount'];
    failedAmount = json['failed_amount'];
    processingAmount = json['processing_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success_amount'] = this.successAmount;
    data['failed_amount'] = this.failedAmount;
    data['processing_amount'] = this.processingAmount;
    return data;
  }
}
