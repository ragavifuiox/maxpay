class Login {
  bool? success;
  Data? data;
  String? message;
  int? code;

  Login({this.success, this.data, this.message, this.code});

  Login.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? phoneNumber;
  String? pincode;
  int? otp;

  Data({this.name, this.phoneNumber, this.pincode, this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    pincode = json['pincode'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['pincode'] = this.pincode;
    data['otp'] = this.otp;
    return data;
  }
}
