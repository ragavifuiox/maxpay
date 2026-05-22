class FingerPrint {
  bool? success;
  Data? data;
  String? message;
  int? code;

  FingerPrint({this.success, this.data, this.message, this.code});

  FingerPrint.fromJson(Map<String, dynamic> json) {
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
  int? isFingerPrint;

  Data({this.isFingerPrint});

  Data.fromJson(Map<String, dynamic> json) {
    isFingerPrint = json['is_finger_print'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_finger_print'] = this.isFingerPrint;
    return data;
  }
}
