class UpdateOtp {
  bool? success;
  List<dynamic>? data;
  String? message;
  int? code;

  UpdateOtp({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  UpdateOtp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? List<dynamic>.from(json['data']) : [];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'message': message,
      'code': code,
    };
  }
}