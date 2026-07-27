class WalletBalanceModel {
  final bool? success;
  final WalletData? data;
  final String? message;
  final int? code;

  WalletBalanceModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    return WalletBalanceModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? WalletData.fromJson(json['data']) : null,
      message: json['message'] as String?,
      code: json['code'] as int?,
    );
  }
}

class WalletData {
  final String? userId;
  final dynamic balance;
  final String? currency;
  final String? currencySymbol;
  final String? name;
  final String? profileImg;

  WalletData({
    this.userId,
    this.balance,
    this.currency,
    this.currencySymbol,
    this.name,
    this.profileImg,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) {
    return WalletData(
      userId: json['user_id'] as String?,
      balance: json['balance'],
      currency: json['currency'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      name: json['name'] as String?,
      profileImg: json['profile_img'] as String?,
    );
  }
}
