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
  double? todayTotalCredit;
  List<CreditData>? list;

  CreditList({this.todayTotalCredit, this.list});

  factory CreditList.fromJson(Map<String, dynamic> json) => CreditList(
    todayTotalCredit: double.tryParse(json["total_credit"].toString()),
    list: json["list"] == null
        ? []
        : List<CreditData>.from(
            json["list"]!.map((x) => CreditData.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "total_credit": todayTotalCredit,
    "list": list == null
        ? []
        : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class CreditData {
  String? transactionId;
  String? amount;
  String? description;
  String? paymentMode;
  String? createdAt;
  String? walletType;
  String? utrNo;

  CreditData({
    this.transactionId,
    this.amount,
    this.description,
    this.paymentMode,
    this.createdAt,
    this.walletType,
    this.utrNo,
  });

  CreditData.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    amount = json['amount'];
    description = json['description'];
    paymentMode = json['payment_mode'];
    createdAt = json['created_at'];
    walletType = json['wallet_type'];
    utrNo = json['utr_no']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['description'] = description;
    data['payment_mode'] = paymentMode;
    data['created_at'] = createdAt;
    data['wallet_type'] = walletType;
    data['utr_no'] = utrNo;
    return data;
  }
}
