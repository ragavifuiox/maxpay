class FingerPrint {
  bool? success;
  FingerData? data;
  String? message;
  int? code;

  FingerPrint({this.success, this.data, this.message, this.code});

  FingerPrint.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? FingerData.fromJson(json['data']) : null;
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

class FingerData {
  int? isFingerPrint;

  FingerData({this.isFingerPrint});

  FingerData.fromJson(Map<String, dynamic> json) {
    isFingerPrint = json['is_finger_print'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_finger_print'] = isFingerPrint;
    return data;
  }
}
