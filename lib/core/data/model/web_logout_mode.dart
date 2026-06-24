class WebLogout {
  bool? success;
  bool? data;
  String? message;
  dynamic code;

  WebLogout({this.success, this.data, this.message, this.code});

  WebLogout.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];

    // 🔥 SAFE PARSING
    code = _parseCode(json['code']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    data['code'] = code;
    return data;
  }

  static dynamic _parseCode(dynamic value) {
    if (value == null) return null;

    if (value is Map<String, dynamic>) {
      return Code.fromJson(value);
    }

    if (value is List) {
      return value; // API gives []
    }

    return value;
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
    return {
      'user_id': userId,
      'is_web_login': isWebLogin,
      'web_login_count': webLoginCount,
    };
  }
}