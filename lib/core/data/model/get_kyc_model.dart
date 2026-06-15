class GetKyc {
  bool? success;
  Data? data;
  String? message;
  int? code;

  GetKyc({this.success, this.data, this.message, this.code});

  GetKyc.fromJson(Map<String, dynamic> json) {
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
  int? kycId;
  int? retailerId;
  String? email;
  String? address;
  String? gstNo;
  String? pan;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.kycId,
      this.retailerId,
      this.email,
      this.address,
      this.gstNo,
      this.pan,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    kycId = json['kyc_id'];
    retailerId = json['retailer_id'];
    email = json['email'];
    address = json['address'];
    gstNo = json['gst_no'];
    pan = json['pan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kyc_id'] = this.kycId;
    data['retailer_id'] = this.retailerId;
    data['email'] = this.email;
    data['address'] = this.address;
    data['gst_no'] = this.gstNo;
    data['pan'] = this.pan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
