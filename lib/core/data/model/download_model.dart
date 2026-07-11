class Download {
  bool? success;
  bool? data;
  String? message;
  Code? code;

  Download({this.success, this.data, this.message, this.code});

  Download.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    code = json['code'] != null ? Code.fromJson(json['code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    if (code != null) {
      data['code'] = code!.toJson();
    }
    return data;
  }
}

class Code {
  String? receiptUrl;

  Code({this.receiptUrl});

  Code.fromJson(Map<String, dynamic> json) {
    receiptUrl = json['receipt_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receipt_url'] = receiptUrl;
    return data;
  }
}
