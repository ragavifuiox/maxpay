class UpdatePin {
  bool? success;
  Data? data;
  String? message;
  int? code;

  UpdatePin({this.success, this.data, this.message, this.code});

  UpdatePin.fromJson(Map<String, dynamic> json) {
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
  bool? pinUpdated;
  String? pin;

  Data({this.userId, this.pinUpdated, this.pin});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    pinUpdated = json['pin_updated'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['pin_updated'] = pinUpdated;
    data['pin'] = pin;
    return data;
  }
}
