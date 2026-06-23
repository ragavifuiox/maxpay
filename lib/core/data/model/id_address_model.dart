class IpAddress {
  bool? success;
  Data? data;
  String? message;
  int? code;

  IpAddress({this.success, this.data, this.message, this.code});

  IpAddress.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? retailerId;
  String? ipAddress;
  String? city;
  String? state;
  Null? country;
  String? network;
  String? loginTime;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.retailerId,
      this.ipAddress,
      this.city,
      this.state,
      this.country,
      this.network,
      this.loginTime,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerId = json['retailer_id'];
    ipAddress = json['ip_address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    network = json['network'];
    loginTime = json['login_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['retailer_id'] = this.retailerId;
    data['ip_address'] = this.ipAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['network'] = this.network;
    data['login_time'] = this.loginTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
