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

class TermsData {
  String? message;

  TermsData({this.message});

  TermsData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
