// To parse this JSON data, do
//
//     final retailorGrade = retailorGradeFromJson(jsonString);

import 'dart:convert';

RetailorGrade retailorGradeFromJson(String str) =>
    RetailorGrade.fromJson(json.decode(str));

String retailorGradeToJson(RetailorGrade data) => json.encode(data.toJson());

class RetailorGrade {
  bool? success;
  Data? data;
  String? message;
  int? code;

  RetailorGrade({this.success, this.data, this.message, this.code});

  factory RetailorGrade.fromJson(Map<String, dynamic> json) => RetailorGrade(
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
  Retailer? retailer;
  double? walletBalance;
  TMonth? currentMonth;
  TMonth? lastMonth;
  DisplayCard? displayCard;
  List<GradeSlab>? gradeSlabs;

  Data({
    this.retailer,
    this.walletBalance,
    this.currentMonth,
    this.lastMonth,
    this.displayCard,
    this.gradeSlabs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    retailer: json["retailer"] == null
        ? null
        : Retailer.fromJson(json["retailer"]),
    walletBalance: json["wallet_balance"] != null
        ? double.tryParse(json["wallet_balance"].toString())
        : null,
    currentMonth: json["current_month"] == null
        ? null
        : TMonth.fromJson(json["current_month"]),
    lastMonth: json["last_month"] == null
        ? null
        : TMonth.fromJson(json["last_month"]),
    displayCard: json["display_card"] == null
        ? null
        : DisplayCard.fromJson(json["display_card"]),
    gradeSlabs: json["grade_slabs"] == null
        ? []
        : List<GradeSlab>.from(
            json["grade_slabs"]!.map((x) => GradeSlab.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "retailer": retailer?.toJson(),
    "wallet_balance": walletBalance,
    "current_month": currentMonth?.toJson(),
    "last_month": lastMonth?.toJson(),
    "display_card": displayCard?.toJson(),
    "grade_slabs": gradeSlabs == null
        ? []
        : List<dynamic>.from(gradeSlabs!.map((x) => x.toJson())),
  };
}

class TMonth {
  String? grade;
  String? monthKey;
  String? monthLabel;
  int? daysTracked;
  double? actualAvg;
  String? label;
  int? cashback;

  TMonth({
    this.grade,
    this.monthKey,
    this.monthLabel,
    this.daysTracked,
    this.actualAvg,
    this.label,
    this.cashback,
  });

  factory TMonth.fromJson(Map<String, dynamic> json) => TMonth(
    grade: json["grade"]?.toString(),
    monthKey: json["month_key"]?.toString(),
    monthLabel: json["month_label"]?.toString(),
    daysTracked: json["days_tracked"] != null
        ? int.tryParse(json["days_tracked"].toString())
        : null,
    actualAvg: json["actual_avg"] != null
        ? double.tryParse(json["actual_avg"].toString())
        : null,
    label: json["label"]?.toString(),
    cashback: json["cashback"] != null
        ? int.tryParse(json["cashback"].toString())
        : null,
  );

  Map<String, dynamic> toJson() => {
    "grade": grade,
    "month_key": monthKey,
    "month_label": monthLabel,
    "days_tracked": daysTracked,
    "actual_avg": actualAvg,
    "label": label,
    "cashback": cashback,
  };
}

class DisplayCard {
  String? grade;
  String? label;
  String? monthLabel;
  String? source;

  DisplayCard({this.grade, this.label, this.monthLabel, this.source});

  factory DisplayCard.fromJson(Map<String, dynamic> json) => DisplayCard(
    grade: json["grade"]?.toString(),
    label: json["label"]?.toString(),
    monthLabel: json["month_label"]?.toString(),
    source: json["source"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "grade": grade,
    "label": label,
    "month_label": monthLabel,
    "source": source,
  };
}

class GradeSlab {
  int? sno;
  String? grade;
  double? dailyAverageBalance;
  double? monthlyCashBack;

  GradeSlab({
    this.sno,
    this.grade,
    this.dailyAverageBalance,
    this.monthlyCashBack,
  });

  factory GradeSlab.fromJson(Map<String, dynamic> json) => GradeSlab(
    sno: json["sno"] != null ? int.tryParse(json["sno"].toString()) : null,
    grade: json["grade"]?.toString(),
    dailyAverageBalance: json["daily_average_balance"] != null
        ? double.tryParse(json["daily_average_balance"].toString())
        : null,
    monthlyCashBack: json["monthly_cash_back"] != null
        ? double.tryParse(json["monthly_cash_back"].toString())
        : null,
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "grade": grade,
    "daily_average_balance": dailyAverageBalance,
    "monthly_cash_back": monthlyCashBack,
  };
}

class Retailer {
  String? userId;
  String? retailerName;
  String? mobile;

  Retailer({this.userId, this.retailerName, this.mobile});

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
    userId: json["user_id"],
    retailerName: json["retailer_name"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "retailer_name": retailerName,
    "mobile": mobile,
  };
}
