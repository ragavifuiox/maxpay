class IpAddress {
  bool? success;
  Data? data;
  String? message;
  int? code;

  IpAddress({this.success, this.data, this.message, this.code});

  IpAddress.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? retailerId;
  String? ipAddress;
  String? city;
  String? state;
  Null country;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['retailer_id'] = retailerId;
    data['ip_address'] = ipAddress;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['network'] = network;
    data['login_time'] = loginTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
