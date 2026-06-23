class MyProfile {
  bool? success;
  Data? data;
  String? message;
  int? code;

  MyProfile({this.success, this.data, this.message, this.code});

  MyProfile.fromJson(Map<String, dynamic> json) {
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
  String? phoneNumber;
  String? email;
  String? pincode;
  String? state;
  String? status;
  String? profileimg;

  Data(
      {this.id,
      this.userId,
      this.name,
      this.phoneNumber,
      this.email,
      this.pincode,
      this.state,
      this.status,
      this.profileimg});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    pincode = json['pincode'];
    state = json['state'];
    status = json['status'];
    profileimg = json['profileimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['pincode'] = pincode;
    data['state'] = state;
    data['status'] = status;
    data['profileimg'] = profileimg;
    return data;
  }
}
