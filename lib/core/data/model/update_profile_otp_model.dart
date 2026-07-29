class UpdateprofileOtp {
  bool? success;
  Data? data;
  String? message;
  int? code;

  UpdateprofileOtp({this.success, this.data, this.message, this.code});

 UpdateprofileOtp.fromJson(Map<String, dynamic> json) {
  success = json['success'];

  if (json['data'] is Map<String, dynamic>) {
    data = Data.fromJson(json['data']);
  } else {
    data = null;
  }

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
  String? userId;
  String? name;
  String? retailerName;
  String? phoneNumber;
  String? regMobileNumber;
  String? whatsappNumber;
  String? billingAddress;
  String? email;
  String? pincode;
  Null state;
  String? status;
  bool? otpRequired;
  bool? mobileChangePending;
  int? mobileRequestId;
  String? requestedNewMobile;

  Data(
      {this.id,
      this.userId,
      this.name,
      this.retailerName,
      this.phoneNumber,
      this.regMobileNumber,
      this.whatsappNumber,
      this.billingAddress,
      this.email,
      this.pincode,
      this.state,
      this.status,
      this.otpRequired,
      this.mobileChangePending,
      this.mobileRequestId,
      this.requestedNewMobile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    retailerName = json['retailer_name'];
    phoneNumber = json['phone_number'];
    regMobileNumber = json['reg_mobile_number'];
    whatsappNumber = json['whatsapp_number'];
    billingAddress = json['billing_address'];
    email = json['email'];
    pincode = json['pincode'];
    state = json['state'];
    status = json['status'];
    otpRequired = json['otp_required'];
    mobileChangePending = json['mobile_change_pending'];
    mobileRequestId = json['mobile_request_id'];
    requestedNewMobile = json['requested_new_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['retailer_name'] = retailerName;
    data['phone_number'] = phoneNumber;
    data['reg_mobile_number'] = regMobileNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['billing_address'] = billingAddress;
    data['email'] = email;
    data['pincode'] = pincode;
    data['state'] = state;
    data['status'] = status;
    data['otp_required'] = otpRequired;
    data['mobile_change_pending'] = mobileChangePending;
    data['mobile_request_id'] = mobileRequestId;
    data['requested_new_mobile'] = requestedNewMobile;
    return data;
  }
}
