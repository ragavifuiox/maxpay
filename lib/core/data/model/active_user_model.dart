class ActiveUser {
  bool? success;
  Data? data;
  String? message;
  int? code;

  ActiveUser({this.success, this.data, this.message, this.code});

  ActiveUser.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['retailer_name'] = this.retailerName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['whatsapp_number'] = this.whatsappNumber;
    data['is_active'] = this.isActive;
    data['profile_img'] = this.profileImg;
    return data;
  }
}
