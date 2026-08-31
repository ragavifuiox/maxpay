class ActiveUser {
  bool? success;
  Data? data;
  String? message;
  int? code;

  ActiveUser({this.success, this.data, this.message, this.code});

  ActiveUser.fromJson(Map<String, dynamic> json) {
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
  String? retailerName;
  String? email;
  String? phoneNumber;
  String? whatsappNumber;
  int? isActive;
  String? profileImg;

  Data({
    this.id,
    this.userId,
    this.retailerName,
    this.email,
    this.phoneNumber,
    this.whatsappNumber,
    this.isActive,
    this.profileImg,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    retailerName = json['retailer_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    whatsappNumber = json['whatsapp_number'];
    isActive = json['is_active'];
    profileImg = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['retailer_name'] = retailerName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['is_active'] = isActive;
    data['profile_img'] = profileImg;
    return data;
  }
}
