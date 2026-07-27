class ProfileModel {
  final bool? success;
  final ProfileData? data;
  final String? message;
  final int? code;

  ProfileModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
      message: json['message'] as String?,
      code: json['code'] as int?,
    );
  }
}

class ProfileData {
  final int? id;
  final String? userId;
  final String? userType;
  final String? name;
  final String? phoneNumber;
  final String? whatsappNumber;
  final String? billingAddress;
  final String? email;
  final String? pincode;
  final String? status;
  final dynamic balance;
  final String? referralCode;
  final String? profileimg;

  ProfileData({
    this.id,
    this.userId,
    this.userType,
    this.name,
    this.phoneNumber,
    this.whatsappNumber,
    this.billingAddress,
    this.email,
    this.pincode,
    this.status,
    this.balance,
    this.referralCode,
    this.profileimg,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      whatsappNumber: json['whatsapp_number'] as String?,
      billingAddress: json['billing_address'] as String?,
      email: json['email'] as String?,
      pincode: json['pincode']?.toString(),
      status: json['status'] as String?,
      balance: json['balance'],
      referralCode: json['referral_code'] as String?,
      profileimg: json['profile_img'] as String?,
    );
  }
}
