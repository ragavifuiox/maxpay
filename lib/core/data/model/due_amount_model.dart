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
  int? pendingAmount;

  Code({this.pendingAmount});

  Code.fromJson(Map<String, dynamic> json) {
    pendingAmount = json['pending_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending_amount'] = this.pendingAmount;
    return data;
  }
}
