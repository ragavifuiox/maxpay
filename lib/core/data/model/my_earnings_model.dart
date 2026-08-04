// To parse this JSON data, do
//
//     final searchEarning = searchEarningFromJson(jsonString);

import 'dart:convert';

SearchEarning searchEarningFromJson(String str) =>
    SearchEarning.fromJson(json.decode(str));

String searchEarningToJson(SearchEarning data) => json.encode(data.toJson());

class SearchEarning {
  bool? success;
  Data? data;
  String? message;
  int? code;

  SearchEarning({this.success, this.data, this.message, this.code});

  factory SearchEarning.fromJson(Map<String, dynamic> json) => SearchEarning(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
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

class Data {
  int? todayTotalEarnings;
  int? totalEarnings;
  List<EarningItem>? list;

  Data({this.todayTotalEarnings, this.totalEarnings, this.list});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    todayTotalEarnings: json["today_total_earnings"],
    totalEarnings: json["total_earnings"],
    list: json["list"] == null
        ? []
        : List<EarningItem>.from(
            json["list"]!.map((x) => EarningItem.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "today_total_earnings": todayTotalEarnings,
    "total_earnings": totalEarnings,
    "list": list == null
        ? []
        : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class EarningItem {
  int? rechargeId;
  String? userName;
  String? mobile;
  int? productId;
  String? productName;
  String? productLogo;
  String? amount;
  String? status;
  String? rechargeDate;
  String? commissionType;
  String? commissionAmount;
  String? commissionDate;
  String? productType;

  EarningItem({
    this.rechargeId,
    this.userName,
    this.mobile,
    this.productId,
    this.productName,
    this.productLogo,
    this.amount,
    this.status,
    this.rechargeDate,
    this.commissionType,
    this.commissionAmount,
    this.commissionDate,
    this.productType,
  });

  EarningItem.fromJson(Map<String, dynamic> json) {
    rechargeId = json['recharge_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    productId = json['product_id'];
    productName = json['product_name'];
    productLogo = json['product_logo'];
    amount = json['amount'];
    status = json['status'];
    rechargeDate = json['recharge_date'];
    commissionType = json['commission_type'];
    commissionAmount = json['commission_amount'];
    commissionDate = json['commission_date'];
    productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'recharge_id': rechargeId,
      'user_name': userName,
      'mobile': mobile,
      'product_id': productId,
      'product_name': productName,
      'product_logo': productLogo,
      'amount': amount,
      'status': status,
      'recharge_date': rechargeDate,
      'commission_type': commissionType,
      'commission_amount': commissionAmount,
      'commission_date': commissionDate,
      'product_type': productType,
    };
  }
}
