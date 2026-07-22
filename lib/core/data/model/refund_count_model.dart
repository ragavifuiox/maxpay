class RefundCount {
  bool? success;
  RefundData? data;
  String? message;
  Code? code;

  RefundCount({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  RefundCount.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    if (json['data'] is Map<String, dynamic>) {
      data = RefundData.fromJson(json['data']);
    } else if (json['data'] is int) {
      data = RefundData(
        refundCount: json['data'],
      );
    }

    message = json['message'];

    if (json['code'] is Map<String, dynamic>) {
      code = Code.fromJson(json['code']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "data": data?.toJson(),
      "message": message,
      "code": code?.toJson(),
    };
  }
}


class RefundData {
  int? refundAmount;
  int? refundCount;

  RefundData({
    this.refundAmount,
    this.refundCount,
  });

  RefundData.fromJson(Map<String, dynamic> json) {
    refundAmount = json['refund_amount'];
    refundCount = json['refund_count'];
  }

  Map<String, dynamic> toJson() {
    return {
      "refund_amount": refundAmount,
      "refund_count": refundCount,
    };
  }
}


class Code {
  int? refundAmount;
  int? count;

  Code({
    this.refundAmount,
    this.count,
  });

  Code.fromJson(Map<String, dynamic> json) {
    refundAmount = json['refund_amount'];
    count = json['refund_count'];
  }

  Map<String, dynamic> toJson() {
    return {
      "refund_amount": refundAmount,
      "refund_count": count,
    };
  }
}