class RefundCount {
  bool? success;
  bool? data;
  String? message;
  Code? code;

  RefundCount({this.success, this.data, this.message, this.code});

  RefundCount.fromJson(Map<String, dynamic> json) {
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
  int? refundAmount;

  Code({this.refundAmount});

  Code.fromJson(Map<String, dynamic> json) {
    refundAmount = json['refund_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refund_amount'] = this.refundAmount;
    return data;
  }
}
