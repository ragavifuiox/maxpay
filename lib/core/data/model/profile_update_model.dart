class ProfileUpdate {
  bool? success;
  Data? data;
  String? message;
  int? code;

  ProfileUpdate({this.success, this.data, this.message, this.code});

  ProfileUpdate.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? name;
  String? retailerName;
  String? email;
  String? phoneNumber;
  String? regMobileNumber;
  String? whatsappNumber;
  String? billingAddress;
  String? pincode;
  Null state;
  bool? otpRequired;
  String? profileImg;

  Data(
      {this.id,
      this.userId,
      this.name,
      this.retailerName,
      this.email,
      this.phoneNumber,
      this.regMobileNumber,
      this.whatsappNumber,
      this.billingAddress,
      this.pincode,
      this.state,
      this.otpRequired,
      this.profileImg});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    retailerName = json['retailer_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    regMobileNumber = json['reg_mobile_number'];
    whatsappNumber = json['whatsapp_number'];
    billingAddress = json['billing_address'];
    pincode = json['pincode'];
    state = json['state'];
    otpRequired = json['otp_required'];
    profileImg = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['retailer_name'] = retailerName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['reg_mobile_number'] = regMobileNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['billing_address'] = billingAddress;
    data['pincode'] = pincode;
    data['state'] = state;
    data['otp_required'] = otpRequired;
    data['profile_img'] = profileImg;
    return data;
  }
}
