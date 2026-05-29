class Credit {
  bool? success;
  Data? data;
  String? message;
  int? code;

  Credit({this.success, this.data, this.message, this.code});

  Credit.fromJson(Map<String, dynamic> json) {
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

  double? totalCredit;

  Data({this.totalCredit});

  Data.fromJson(Map<String, dynamic> json) {

    totalCredit = double.tryParse(
      json['total_credit'].toString(),
    );
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = {};

    data['total_credit'] = totalCredit;

    return data;
  }
}