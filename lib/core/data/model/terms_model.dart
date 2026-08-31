class Terms {
  bool? success;
  TermsData? data;
  String? message;
  int? code;

  Terms({this.success, this.data, this.message, this.code});

  Terms.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?TermsData.fromJson(json['data']) : null;
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

class TermsData {
  String? message;

  TermsData({this.message});

  TermsData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
