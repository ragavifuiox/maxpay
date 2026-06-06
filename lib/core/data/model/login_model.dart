class Login {
  bool? success;
  Data? data;
  String? message;
  int? code;

  Login({this.success, this.data, this.message, this.code});

  Login.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['pincode'] = pincode;
    data['otp'] = otp;
    return data;
  }
}
