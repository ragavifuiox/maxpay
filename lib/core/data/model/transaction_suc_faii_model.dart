class TransactionResponse {
  bool? success;
  Data? data;
  String? message;
  int? code;

  TransactionResponse({this.success, this.data, this.message, this.code});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
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
  Success? success;
  Success? failed;
  Success? processing;

  Data({this.success, this.failed, this.processing});

  Data.fromJson(Map<String, dynamic> json) {
    success =
        json['success'] != null ? new Success.fromJson(json['success']) : null;
    failed =
        json['failed'] != null ? new Success.fromJson(json['failed']) : null;
    processing = json['processing'] != null
        ? new Success.fromJson(json['processing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    if (this.failed != null) {
      data['failed'] = this.failed!.toJson();
    }
    if (this.processing != null) {
      data['processing'] = this.processing!.toJson();
    }
    return data;
  }
}

class Success {
  int? amount;
  int? count;

  Success({this.amount, this.count});

  Success.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['count'] = this.count;
    return data;
  }
}
