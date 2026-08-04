// To parse this JSON data, do
//
//     final creditListModel = creditListModelFromJson(jsonString);

import 'dart:convert';

CreditListModel creditListModelFromJson(String str) =>
    CreditListModel.fromJson(json.decode(str));

String creditListModelToJson(CreditListModel data) =>
    json.encode(data.toJson());

class CreditListModel {
  bool? success;
  CreditList? data;
  String? message;
  int? code;

  CreditListModel({this.success, this.data, this.message, this.code});

  factory CreditListModel.fromJson(Map<String, dynamic> json) =>
      CreditListModel(
        success: json["success"],
        data: json["data"] == null ? null : CreditList.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class CreditList {
  int? todayTotalCredit;
  List<CreditData>? list;

  CreditList({this.todayTotalCredit, this.list});

  factory CreditList.fromJson(Map<String, dynamic> json) => CreditList(
    todayTotalCredit: json["today_total_credit"],
    list: json["list"] == null
        ? []
        : List<CreditData>.from(json["list"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "today_total_credit": todayTotalCredit,
    "list": list == null ? [] : List<CreditData>.from(list!.map((x) => x)),
  };
}

class CreditData {
  String? transactionId;
  String? amount;
  String? description;
  String? paymentMode;
  String? createdAt;
  String? walletType;

  CreditData({
    this.transactionId,
    this.amount,
    this.description,
    this.paymentMode,
    this.createdAt,
    this.walletType,
  });

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
