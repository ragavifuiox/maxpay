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
  int? refundAmount;

  Code({this.refundAmount});

  Code.fromJson(Map<String, dynamic> json) {
    refundAmount = json['refund_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refund_amount'] = refundAmount;
    return data;
  }
}
