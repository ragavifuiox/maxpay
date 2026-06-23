class LoginHistory {
  bool? status;
  String? message;
  List<LogHistoryData>? data;

  LoginHistory({this.status, this.message, this.data});

  LoginHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LogHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new LogHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LogHistoryData {
  String? city;
  String? network;
  String? ipAddress;
  String? loginTime;

  LogHistoryData({this.city, this.network, this.ipAddress, this.loginTime});

  LogHistoryData.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    network = json['network'];
    ipAddress = json['ip_address'];
    loginTime = json['login_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['network'] = this.network;
    data['ip_address'] = this.ipAddress;
    data['login_time'] = this.loginTime;
    return data;
  }
}
