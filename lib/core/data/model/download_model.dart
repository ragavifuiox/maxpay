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
    code = json['code'] != null ? new Code.fromJson(json['code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    if (this.code != null) {
      data['code'] = this.code!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_url'] = this.receiptUrl;
    return data;
  }
}
