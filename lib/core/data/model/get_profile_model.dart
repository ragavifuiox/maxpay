class MyProfile {
  bool? success;
  Data? data;
  String? message;
  int? code;

  MyProfile({this.success, this.data, this.message, this.code});

  MyProfile.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? phoneNumber;
  String? email;
  String? pincode;
  String? state;
  String? status;

  Data(
      {this.id,
      this.userId,
      this.name,
      this.phoneNumber,
      this.email,
      this.pincode,
      this.state,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    pincode = json['pincode'];
    state = json['state'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}
