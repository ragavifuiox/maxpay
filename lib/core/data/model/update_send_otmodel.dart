class SendUpdatePinOtpResponse {
  bool? success;
  String? message;
  int? code;
  OtpData? data;

  SendUpdatePinOtpResponse({
    this.success,
    this.message,
    this.code,
    this.data,
  });

  factory SendUpdatePinOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendUpdatePinOtpResponse(
      success: json["success"],
      message: json["message"],
      code: json["code"],
      data: json["data"] != null
          ? OtpData.fromJson(json["data"])
          : null,
    );
  }
}

class OtpData {
  String? mobile;
  int? otp;

  OtpData({
    this.mobile,
    this.otp,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      mobile: json["mobile"],
      otp: json["otp"],
    );
  }
}