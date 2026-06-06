class Complaints {
  bool? success;
  Data? data;
  String? message;
  int? code;

  Complaints({this.success, this.data, this.message, this.code});

  Complaints.fromJson(Map<String, dynamic> json) {
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
  int? complaintCount;

  Data({this.complaintCount});

  Data.fromJson(Map<String, dynamic> json) {
    complaintCount = json['complaint_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['complaint_count'] = complaintCount;
    return data;
  }
}
