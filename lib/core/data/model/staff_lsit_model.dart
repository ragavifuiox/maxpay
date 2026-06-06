class StaffList {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  StaffList({this.success, this.data, this.message, this.code});

  StaffList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? name;
  String? mobile;
  String? packageName;
  String? walletBalance;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.name,
      this.mobile,
      this.packageName,
      this.walletBalance,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    mobile = json['mobile'];
    packageName = json['package_name'];
    walletBalance = json['wallet_balance'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['package_name'] = packageName;
    data['wallet_balance'] = walletBalance;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
