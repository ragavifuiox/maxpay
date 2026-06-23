class WebLogin {
  bool? success;
  bool? data;
  String? message;
  Code? code;

  WebLogin({this.success, this.data, this.message, this.code});

  WebLogin.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  int? isWebLogin;
  int? webLoginCount;

  Code({this.userId, this.isWebLogin, this.webLoginCount});

  Code.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    isWebLogin = json['is_web_login'];
    webLoginCount = json['web_login_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['is_web_login'] = this.isWebLogin;
    data['web_login_count'] = this.webLoginCount;
    return data;
  }
}
