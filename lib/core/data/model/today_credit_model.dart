class TodayCredit {
  bool? success;
  bool? data;
  String? message;
  Code? code;

  TodayCredit({this.success, this.data, this.message, this.code});

  TodayCredit.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    code = json['code'] != null ? Code.fromJson(json['code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    if (code != null) {
      data['code'] = code!.toJson();
    }
    return data;
  }
}

class Code {
  int? todayCreditAmount;

  Code({this.todayCreditAmount});

  Code.fromJson(Map<String, dynamic> json) {
    todayCreditAmount = json['today_credit_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['today_credit_amount'] = todayCreditAmount;
    return data;
  }
}
