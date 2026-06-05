



class SearchStaff {
  bool? success;
  Data? data;
  String? message;
  int? code;

  SearchStaff({this.success, this.data, this.message, this.code});

  SearchStaff.fromJson(Map<String, dynamic> json) {
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
  SearchStaffData? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SearchStaffData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  Null? walletBalance;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['retailer_name'] = this.retailerName;
    data['reg_mobile_number'] = this.regMobileNumber;
    data['commission_package'] = this.commissionPackage;
    data['wallet_balance'] = this.walletBalance;
    return data;
  }
}
