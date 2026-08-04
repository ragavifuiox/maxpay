class SearchEarning {
  bool? success;
  Data? data;
  String? message;
  int? code;

  SearchEarning({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  SearchEarning.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
      'code': code,
    };
  }
}

class Data {
  double? totalEarnings;
  List<EarningItem>? list;

  Data({
    this.totalEarnings,
    this.list,
  });

  Data.fromJson(Map<String, dynamic> json) {
   totalEarnings = (json['total_earnings'] as num?)?.toDouble();
    if (json['list'] != null) {
      list = (json['list'] as List)
          .map((e) => EarningItem.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'total_earnings': totalEarnings,
      'list': list?.map((e) => e.toJson()).toList(),
    };
  }
}

class EarningItem {
  int? rechargeId;
  String? userName;
  String? mobile;
  int? productId;
  String? productName;
  String? productLogo;
  String? amount;
  String? status;
  String? rechargeDate;
  String? commissionType;
  String? commissionAmount;
  String? commissionDate;
  String? productType;

  EarningItem({
    this.rechargeId,
    this.userName,
    this.mobile,
    this.productId,
    this.productName,
    this.productLogo,
    this.amount,
    this.status,
    this.rechargeDate,
    this.commissionType,
    this.commissionAmount,
    this.commissionDate,
    this.productType,
  });

  EarningItem.fromJson(Map<String, dynamic> json) {
    rechargeId = json['recharge_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    productId = json['product_id'];
    productName = json['product_name'];
    productLogo = json['product_logo'];
    amount = json['amount'];
    status = json['status'];
    rechargeDate = json['recharge_date'];
    commissionType = json['commission_type'];
    commissionAmount = json['commission_amount'];
    commissionDate = json['commission_date'];
    productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'recharge_id': rechargeId,
      'user_name': userName,
      'mobile': mobile,
      'product_id': productId,
      'product_name': productName,
      'product_logo': productLogo,
      'amount': amount,
      'status': status,
      'recharge_date': rechargeDate,
      'commission_type': commissionType,
      'commission_amount': commissionAmount,
      'commission_date': commissionDate,
      'product_type': productType,
    };
  }
}