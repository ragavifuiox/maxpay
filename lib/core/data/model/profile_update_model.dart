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
  String? retailerName;
  String? email;
  String? regMobileNumber;
  String? whatsappNumber;
  String? profileImg;

  Data({
    this.retailerName,
    this.email,
    this.regMobileNumber,
    this.whatsappNumber,
    this.profileImg,
  });

  Data.fromJson(Map<String, dynamic> json) {
    retailerName = json['retailer_name'];
    email = json['email'];
    regMobileNumber = json['reg_mobile_number'];
    whatsappNumber = json['whatsapp_number'];
    profileImg = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['retailer_name'] = retailerName;
    data['email'] = email;
    data['reg_mobile_number'] = regMobileNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['profile_img'] = profileImg;
    return data;
  }
}
