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
    code = json['code'] != null ? new Code.fromJson(json['code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    if (this.code != null) {
      data['code'] = this.code!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today_credit_amount'] = this.todayCreditAmount;
    return data;
  }
}
