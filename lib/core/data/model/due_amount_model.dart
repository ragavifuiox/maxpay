class DueAmount {
  bool? success;
  bool? data;
  String? message;
  Code? code;

  DueAmount({this.success, this.data, this.message, this.code});

  DueAmount.fromJson(Map<String, dynamic> json) {
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
  int? pendingAmount;

  Code({this.pendingAmount});

  Code.fromJson(Map<String, dynamic> json) {
    pendingAmount = json['pending_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pending_amount'] = pendingAmount;
    return data;
  }
}
