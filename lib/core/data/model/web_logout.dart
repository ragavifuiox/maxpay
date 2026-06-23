class WebLogout {
  bool? success;
  bool? data;
  String? message;
  Code? code;

  WebLogout({this.success, this.data, this.message, this.code});

  WebLogout.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['is_web_login'] = isWebLogin;
    data['web_login_count'] = webLoginCount;
    return data;
  }
}
