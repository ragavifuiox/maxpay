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
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['A'] = this.a;
    data['B'] = this.b;
    data['C'] = this.c;
    data['D'] = this.d;
    data['E'] = this.e;
    data['A_daily_avg_balance'] = this.aDailyAvgBalance;
    data['B_daily_avg_balance'] = this.bDailyAvgBalance;
    data['C_daily_avg_balance'] = this.cDailyAvgBalance;
    data['D_daily_avg_balance'] = this.dDailyAvgBalance;
    data['E_daily_avg_balance'] = this.eDailyAvgBalance;
    data['A_monthly_cashback'] = this.aMonthlyCashback;
    data['B_monthly_cashback'] = this.bMonthlyCashback;
    data['C_monthly_cashback'] = this.cMonthlyCashback;
    data['D_monthly_cashback'] = this.dMonthlyCashback;
    data['E_monthly_cashback'] = this.eMonthlyCashback;
    data['created_date'] = this.createdDate;
    return data;
  }
}
