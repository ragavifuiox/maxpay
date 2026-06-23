class WalletReport {
  bool? success;
  List<WalReportData>? data;
  String? message;
  int? code;

  WalletReport({this.success, this.data, this.message, this.code});

  WalletReport.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <WalReportData>[];
      json['data'].forEach((v) {
        data!.add(WalReportData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class WalReportData {
  int? id;
  String? txnId;
  String? retailerId;
  String? staffId;
  String? paymentType;
  String? amount;
  String? createdAt;

  WalReportData({
    this.id,
    this.txnId,
    this.retailerId,
    this.staffId,
    this.paymentType,
    this.amount,
    this.createdAt,
  });

  WalReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    txnId = json['txn_id']?.toString();
    retailerId = json['retailer_id']?.toString();
    staffId = json['staff_id']?.toString();
    paymentType = json['payment_type']?.toString();
    amount = json['amount']?.toString();
    createdAt = json['created_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['txn_id'] = txnId;
    data['retailer_id'] = retailerId;
    data['staff_id'] = staffId;
    data['payment_type'] = paymentType;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    return data;
  }
}
