class OtpResponse {
  bool? success;
  Data? data;
  String? message;
  int? code;

  OtpResponse({this.success, this.data, this.message, this.code});

  OtpResponse.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? isFingerPrint;
  int? isNewUser;
  String? token;

  Data({this.userId, this.isFingerPrint, this.isNewUser, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    isFingerPrint = json['is_finger_print'];
    isNewUser = json['is_new_user'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['is_finger_print'] = this.isFingerPrint;
    data['is_new_user'] = this.isNewUser;
    data['token'] = this.token;
    return data;
  }
}
