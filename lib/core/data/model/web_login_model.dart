class WebLogin {
  bool? success;
  String? message;
  bool? errors;
  Code? code;

  WebLogin({
    this.success,
    this.message,
    this.errors,
    this.code,
  });

  factory WebLogin.fromJson(Map<String, dynamic> json) {
    return WebLogin(
      success: json['success'],
      message: json['message'],
      errors: json['errors'],
      code: json['code'] is Map<String, dynamic>
          ? Code.fromJson(json['code'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'errors': errors,
      'code': code?.toJson(),
    };
  }
}

class Code {
  String? userId;
  int? isWebLogin;
  int? webLoginCount;

  Code({this.userId, this.isWebLogin, this.webLoginCount});

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      userId: json['user_id'],
      isWebLogin: json['is_web_login'],
      webLoginCount: json['web_login_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'is_web_login': isWebLogin,
      'web_login_count': webLoginCount,
    };
  }
}