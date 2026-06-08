class TransactionResponse {
  bool? success;
  Data? data;
  String? message;
  int? code;

  TransactionResponse({this.success, this.data, this.message, this.code});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
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
  Success? success;
  Success? failed;
  Success? processing;

  Data({this.success, this.failed, this.processing});

  Data.fromJson(Map<String, dynamic> json) {
    success =
        json['success'] != null ? Success.fromJson(json['success']) : null;
    failed =
        json['failed'] != null ? Success.fromJson(json['failed']) : null;
    processing = json['processing'] != null
        ? Success.fromJson(json['processing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (success != null) {
      data['success'] = success!.toJson();
    }
    if (failed != null) {
      data['failed'] = failed!.toJson();
    }
    if (processing != null) {
      data['processing'] = processing!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['count'] = count;
    return data;
  }
}
