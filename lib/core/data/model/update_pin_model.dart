class UpdatePin {
  bool? success;
  Data? data;
  String? message;
  int? code;

  UpdatePin({this.success, this.data, this.message, this.code});

  UpdatePin.fromJson(Map<String, dynamic> json) {
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
  bool? pinUpdated;
  String? pin;

  Data({this.userId, this.pinUpdated, this.pin});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    pinUpdated = json['pin_updated'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['pin_updated'] = this.pinUpdated;
    data['pin'] = this.pin;
    return data;
  }
}
