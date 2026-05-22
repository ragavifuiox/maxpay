class CreatePin {
  bool? success;
  Data? data;
  String? message;
  int? code;

  CreatePin({this.success, this.data, this.message, this.code});

  CreatePin.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['pincode'] = this.pincode;
    data['pin'] = this.pin;
    return data;
  }
}
