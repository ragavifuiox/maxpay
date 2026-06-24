// class WebLogout {
//   bool? success;
//   bool? data;
//   String? message;
//   Code? code;

//   WebLogout({
//     this.success,
//     this.data,
//     this.message,
//     this.code,
//   });

//   factory WebLogout.fromJson(Map<String, dynamic> json) {
//     return WebLogout(
//       success: json['success'] as bool?,
//       data: json['data'] is bool ? json['data'] : null,
//       message: json['message'] as String?,
//       code: _parseCode(json['code']),
//     );
//   }

//   static Code? _parseCode(dynamic value) {
//     if (value is Map<String, dynamic>) {
//       return Code.fromJson(value);
//     }
//     return null; // ✅ fixes [] and null
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'success': success,
//       'data': data,
//       'message': message,
//       'code': code?.toJson(),
//     };
//   }
// }

// class Code {
//   String? userId;
//   int? isWebLogin;
//   int? webLoginCount;

//   Code({this.userId, this.isWebLogin, this.webLoginCount});

//   factory Code.fromJson(Map<String, dynamic> json) {
//     return Code(
//       userId: json['user_id']?.toString(),
//       isWebLogin: _toInt(json['is_web_login']),
//       webLoginCount: _toInt(json['web_login_count']),
//     );
//   }

//   static int? _toInt(dynamic value) {
//     if (value is int) return value;
//     if (value is String) return int.tryParse(value);
//     return null;
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'user_id': userId,
//       'is_web_login': isWebLogin,
//       'web_login_count': webLoginCount,
//     };
//   }
// }
