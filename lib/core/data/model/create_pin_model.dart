class CreatePin {
  bool? success;
  Data? data;
  String? message;
  int? code;

  CreatePin({this.success, this.data, this.message, this.code});

  CreatePin.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? name;
  String? phoneNumber;
  String? pincode;
  String? pin;

  Data({this.userId, this.name, this.phoneNumber, this.pincode, this.pin});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    pincode = json['pincode'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['pincode'] = pincode;
    data['pin'] = pin;
    return data;
  }
}
