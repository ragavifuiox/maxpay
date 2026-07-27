class SupportModel {
  final bool? success;
  final List<SupportData>? data;
  final String? message;
  final int? code;

  SupportModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? (json['data'] as List).map((i) => SupportData.fromJson(i)).toList()
          : null,
      message: json['message'] as String?,
      code: json['code'] as int?,
    );
  }
}

class SupportData {
  final String? title;
  final String? phoneNumber;
  final String? whatsappNumber;
  final String? email;
  final int? whatsappEnabled;
  final int? callEnabled;
  final String? iconUrl;

  SupportData({
    this.title,
    this.phoneNumber,
    this.whatsappNumber,
    this.email,
    this.whatsappEnabled,
    this.callEnabled,
    this.iconUrl,
  });

  factory SupportData.fromJson(Map<String, dynamic> json) {
    return SupportData(
      title: json['title'] as String?,
      phoneNumber: json['phone_number'] as String?,
      whatsappNumber: json['whatsapp_number'] as String?,
      email: json['email'] as String?,
      whatsappEnabled: json['whatsapp_enabled'] as int?,
      callEnabled: json['call_enabled'] as int?,
      iconUrl: json['icon_url'] as String?,
    );
  }
}
