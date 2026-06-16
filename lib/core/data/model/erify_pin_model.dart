class VerifyPin {
  bool? success;
  Data? data;
  String? message;
  int? code;

  VerifyPin({this.success, this.data, this.message, this.code});

  VerifyPin.fromJson(Map<String, dynamic> json) {
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
  bool? verified;

  Data({this.verified});

  Data.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verified'] = verified;
    return data;
  }
}
