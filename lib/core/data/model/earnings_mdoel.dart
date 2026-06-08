class Earnings {
  bool? success;
  Data? data;
  String? message;
  int? code;

  Earnings({this.success, this.data, this.message, this.code});

  Earnings.fromJson(Map<String, dynamic> json) {
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

  double? totalEarnings;

  Data({this.totalEarnings});

  Data.fromJson(Map<String, dynamic> json) {

    totalEarnings = double.tryParse(
      json['total_earnings'].toString(),
    );
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = {};

    data['total_earnings'] = totalEarnings;

    return data;
  }
}

