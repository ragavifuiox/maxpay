class CreditList {
  bool? success;
  List<CreditData>? data;
  String? message;
  int? code;

  CreditList({this.success, this.data, this.message, this.code});

  CreditList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CreditData>[];
      json['data'].forEach((v) {
        data!.add(CreditData.fromJson(v));
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

class CreditData {
  String? transactionId;
  String? amount;
  String? description;
  String? paymentMode;
  String? createdAt;
  String? walletType;

  CreditData(
      {this.transactionId,
      this.amount,
      this.description,
      this.paymentMode,
      this.createdAt,
      this.walletType});

  CreditData.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    amount = json['amount'];
    description = json['description'];
    paymentMode = json['payment_mode'];
    createdAt = json['created_at'];
    walletType = json['wallet_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['description'] = description;
    data['payment_mode'] = paymentMode;
    data['created_at'] = createdAt;
    data['wallet_type'] = walletType;
    return data;
  }
}
