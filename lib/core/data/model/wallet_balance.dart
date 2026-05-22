class WalletBalance {
  bool? success;
  Data? data;
  String? message;
  int? code;

  WalletBalance({this.success, this.data, this.message, this.code});

  WalletBalance.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String? userId;
  int? balance;

  Data({this.userId, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['balance'] = this.balance;
    return data;
  }
}
