class TodayCredit {
  bool? success;
  Code? data;
  String? message;

  TodayCredit({
    this.success,
    this.data,
    this.message,
  });

  TodayCredit.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Code.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class Code {
  int? todayCreditAmount;
  int? totalcreditamount;

  Code({
    this.todayCreditAmount,
    this.totalcreditamount,
  });

  Code.fromJson(Map<String, dynamic> json) {
    todayCreditAmount = json['today_credit_amount'];
    todayCreditAmount = json['today_credit_amount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'today_credit_amount': todayCreditAmount,
    };
  }
}