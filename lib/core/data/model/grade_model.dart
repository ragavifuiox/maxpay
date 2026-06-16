class Grade {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  Grade({this.success, this.data, this.message, this.code});

  Grade.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? userType;
  String? a;
  String? b;
  String? c;
  String? d;
  String? e;
  String? aDailyAvgBalance;
  String? bDailyAvgBalance;
  String? cDailyAvgBalance;
  String? dDailyAvgBalance;
  String? eDailyAvgBalance;
  String? aMonthlyCashback;
  String? bMonthlyCashback;
  String? cMonthlyCashback;
  String? dMonthlyCashback;
  String? eMonthlyCashback;
  String? createdDate;

  Data(
      {this.id,
      this.userType,
      this.a,
      this.b,
      this.c,
      this.d,
      this.e,
      this.aDailyAvgBalance,
      this.bDailyAvgBalance,
      this.cDailyAvgBalance,
      this.dDailyAvgBalance,
      this.eDailyAvgBalance,
      this.aMonthlyCashback,
      this.bMonthlyCashback,
      this.cMonthlyCashback,
      this.dMonthlyCashback,
      this.eMonthlyCashback,
      this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    a = json['A'];
    b = json['B'];
    c = json['C'];
    d = json['D'];
    e = json['E'];
    aDailyAvgBalance = json['A_daily_avg_balance'];
    bDailyAvgBalance = json['B_daily_avg_balance'];
    cDailyAvgBalance = json['C_daily_avg_balance'];
    dDailyAvgBalance = json['D_daily_avg_balance'];
    eDailyAvgBalance = json['E_daily_avg_balance'];
    aMonthlyCashback = json['A_monthly_cashback'];
    bMonthlyCashback = json['B_monthly_cashback'];
    cMonthlyCashback = json['C_monthly_cashback'];
    dMonthlyCashback = json['D_monthly_cashback'];
    eMonthlyCashback = json['E_monthly_cashback'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['A'] = a;
    data['B'] = b;
    data['C'] = c;
    data['D'] = d;
    data['E'] = e;
    data['A_daily_avg_balance'] = aDailyAvgBalance;
    data['B_daily_avg_balance'] = bDailyAvgBalance;
    data['C_daily_avg_balance'] = cDailyAvgBalance;
    data['D_daily_avg_balance'] = dDailyAvgBalance;
    data['E_daily_avg_balance'] = eDailyAvgBalance;
    data['A_monthly_cashback'] = aMonthlyCashback;
    data['B_monthly_cashback'] = bMonthlyCashback;
    data['C_monthly_cashback'] = cMonthlyCashback;
    data['D_monthly_cashback'] = dMonthlyCashback;
    data['E_monthly_cashback'] = eMonthlyCashback;
    data['created_date'] = createdDate;
    return data;
  }
}
