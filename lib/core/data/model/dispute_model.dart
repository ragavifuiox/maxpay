class Dispute {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  Dispute({this.success, this.data, this.message, this.code});

  Dispute.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != String) {
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
    if (this.data != String) {
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
  int? rechargeId;
  String? subject;
  String? description;
  String? status;
  String? adminReply;
  String? createdAt;
  String? updatedAt;
  String? retailerName;
  String? regMobileNumber;
  String? email;
  String? password;
  String? pwdHint;
  String? otp;
  int? otpVerified;
  String? otpExpiresAt;
  String? billingAddress;
  String? state;
  String? pincode;
  String? commissionPackage;
  String? distributorId;
  String? distributor;
  String? registrationCharge;
  String? whatsappNumber;
  String? specialUser;
  String? creditAvailability;
  String? monthlyLimitTransaction;
  String? dailyLimitTransaction;
  String? walletLimit;
  String? minimumPurchase;
  String? onlineMinimumPurchase;
  String? webTransaction;
  String? appTransaction;
  String? onlineTransaction;
  String? dueAmountPopup;
  String? walletTransfer;
  String? lowBalanceAlert;
  String? walletBalance;
  int? isActive;
  String? createdBy;
  String? webOtp;
  String? pin;
  int? isFingerPrint;
  int? isNewUser;
  String? profileImg;

  Data(
      {this.id,
      this.userId,
      this.rechargeId,
      this.subject,
      this.description,
      this.status,
      this.adminReply,
      this.createdAt,
      this.updatedAt,
      this.retailerName,
      this.regMobileNumber,
      this.email,
      this.password,
      this.pwdHint,
      this.otp,
      this.otpVerified,
      this.otpExpiresAt,
      this.billingAddress,
      this.state,
      this.pincode,
      this.commissionPackage,
      this.distributorId,
      this.distributor,
      this.registrationCharge,
      this.whatsappNumber,
      this.specialUser,
      this.creditAvailability,
      this.monthlyLimitTransaction,
      this.dailyLimitTransaction,
      this.walletLimit,
      this.minimumPurchase,
      this.onlineMinimumPurchase,
      this.webTransaction,
      this.appTransaction,
      this.onlineTransaction,
      this.dueAmountPopup,
      this.walletTransfer,
      this.lowBalanceAlert,
      this.walletBalance,
      this.isActive,
      this.createdBy,
      this.webOtp,
      this.pin,
      this.isFingerPrint,
      this.isNewUser,
      this.profileImg});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    rechargeId = json['recharge_id'];
    subject = json['subject'];
    description = json['description'];
    status = json['status'];
    adminReply = json['admin_reply'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    retailerName = json['retailer_name'];
    regMobileNumber = json['reg_mobile_number'];
    email = json['email'];
    password = json['password'];
    pwdHint = json['pwd_hint'];
    otp = json['otp'];
    otpVerified = json['otp_verified'];
    otpExpiresAt = json['otp_expires_at'];
    billingAddress = json['billing_address'];
    state = json['state'];
    pincode = json['pincode'];
    commissionPackage = json['commission_package'];
    distributorId = json['distributor_id'];
    distributor = json['distributor'];
    registrationCharge = json['registration_charge'];
    whatsappNumber = json['whatsapp_number'];
    specialUser = json['special_user'];
    creditAvailability = json['credit_availability'];
    monthlyLimitTransaction = json['monthly_limit_transaction'];
    dailyLimitTransaction = json['daily_limit_transaction'];
    walletLimit = json['wallet_limit'];
    minimumPurchase = json['minimum_purchase'];
    onlineMinimumPurchase = json['online_minimum_purchase'];
    webTransaction = json['web_transaction'];
    appTransaction = json['app_transaction'];
    onlineTransaction = json['online_transaction'];
    dueAmountPopup = json['due_amount_popup'];
    walletTransfer = json['wallet_transfer'];
    lowBalanceAlert = json['low_balance_alert'];
    walletBalance = json['wallet_balance'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    webOtp = json['web_otp'];
    pin = json['pin'];
    isFingerPrint = json['is_finger_print'];
    isNewUser = json['is_new_user'];
    profileImg = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['recharge_id'] = rechargeId;
    data['subject'] = subject;
    data['description'] = description;
    data['status'] = status;
    data['admin_reply'] = adminReply;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['retailer_name'] = retailerName;
    data['reg_mobile_number'] = regMobileNumber;
    data['email'] = email;
    data['password'] = password;
    data['pwd_hint'] = pwdHint;
    data['otp'] = otp;
    data['otp_verified'] = otpVerified;
    data['otp_expires_at'] = otpExpiresAt;
    data['billing_address'] = billingAddress;
    data['state'] = state;
    data['pincode'] = pincode;
    data['commission_package'] = commissionPackage;
    data['distributor_id'] = distributorId;
    data['distributor'] = distributor;
    data['registration_charge'] = registrationCharge;
    data['whatsapp_number'] = whatsappNumber;
    data['special_user'] = specialUser;
    data['credit_availability'] = creditAvailability;
    data['monthly_limit_transaction'] = monthlyLimitTransaction;
    data['daily_limit_transaction'] = dailyLimitTransaction;
    data['wallet_limit'] = walletLimit;
    data['minimum_purchase'] = minimumPurchase;
    data['online_minimum_purchase'] = onlineMinimumPurchase;
    data['web_transaction'] = webTransaction;
    data['app_transaction'] = appTransaction;
    data['online_transaction'] = onlineTransaction;
    data['due_amount_popup'] = dueAmountPopup;
    data['wallet_transfer'] = walletTransfer;
    data['low_balance_alert'] = lowBalanceAlert;
    data['wallet_balance'] = walletBalance;
    data['is_active'] = isActive;
    data['created_by'] = createdBy;
    data['web_otp'] = webOtp;
    data['pin'] = pin;
    data['is_finger_print'] = isFingerPrint;
    data['is_new_user'] = isNewUser;
    data['profile_img'] = profileImg;
    return data;
  }
}
