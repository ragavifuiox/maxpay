class UserDataModel {
  final int? userId;
  final String? name;
  final String? phoneNumber;
  final int? otp;
  final int? isPin;
  final int? isFingerPrint;
  final int? isNewUser;
  final String? token;

  UserDataModel({
    this.userId,
    this.name,
    this.phoneNumber,
    this.otp,
    this.isPin,
    this.isFingerPrint,
    this.isNewUser,
    this.token,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json['user_id'] as int?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      otp: json['otp'] as int?,
      isPin: json['is_pin'] as int?,
      isFingerPrint: json['is_finger_print'] as int?,
      isNewUser: json['is_new_user'] as int?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'phone_number': phoneNumber,
      'otp': otp,
      'is_pin': isPin,
      'is_finger_print': isFingerPrint,
      'is_new_user': isNewUser,
      'token': token,
    };
  }
}

class LoginModel {
  final bool? success;
  final String? message;
  final int? code;
  final UserDataModel? data;

  LoginModel({
    this.success,
    this.message,
    this.code,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      code: json['code'] as int?,
      data: json['data'] != null ? UserDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'code': code,
      'data': data?.toJson(),
    };
  }
}
