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
  int? successCount;
  int? failedAmount;
  int? failedCount;
  int? processingAmount;
  int? processingCount;

  Data(
      {this.successAmount,
      this.successCount,
      this.failedAmount,
      this.failedCount,
      this.processingAmount,
      this.processingCount});

  Data.fromJson(Map<String, dynamic> json) {
    successAmount = json['success_amount'];
    successCount = json['success_count'];
    failedAmount = json['failed_amount'];
    failedCount = json['failed_count'];
    processingAmount = json['processing_amount'];
    processingCount = json['processing_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success_amount'] = this.successAmount;
    data['success_count'] = this.successCount;
    data['failed_amount'] = this.failedAmount;
    data['failed_count'] = this.failedCount;
    data['processing_amount'] = this.processingAmount;
    data['processing_count'] = this.processingCount;
    return data;
  }
}
