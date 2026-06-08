



class SearchStaff {
  bool? success;
  Data? data;
  String? message;
  int? code;

  SearchStaff({this.success, this.data, this.message, this.code});

  SearchStaff.fromJson(Map<String, dynamic> json) {
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
  SearchStaffData? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? SearchStaffData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SearchStaffData {
  String? userId;
  String? retailerName;
  String? regMobileNumber;
  String? commissionPackage;
  Null walletBalance;

  SearchStaffData(
      {this.userId,
      this.retailerName,
      this.regMobileNumber,
      this.commissionPackage,
      this.walletBalance});

  SearchStaffData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    retailerName = json['retailer_name'];
    regMobileNumber = json['reg_mobile_number'];
    commissionPackage = json['commission_package'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['retailer_name'] = retailerName;
    data['reg_mobile_number'] = regMobileNumber;
    data['commission_package'] = commissionPackage;
    data['wallet_balance'] = walletBalance;
    return data;
  }
}
