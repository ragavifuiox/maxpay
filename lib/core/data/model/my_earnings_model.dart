class MyEarning {
  bool? success;
  EarningsData? data;
  String? message;
  int? code;

  MyEarning({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  MyEarning.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? EarningsData.fromJson(json['data']) : null;
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

class EarningsData {
  String? totalEarnings;
  List<EarningItem>? list;

  EarningsData({
    this.totalEarnings,
    this.list,
  });

  EarningsData.fromJson(Map<String, dynamic> json) {
    totalEarnings = json['total_earnings'];

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
  String? amount;
  String? status;
  String? rechargeDate;
  String? commissionType;
  String? commissionAmount;
  String? commissionDate;

  EarningItem({
    this.rechargeId,
    this.userName,
    this.mobile,
    this.productId,
    this.amount,
    this.status,
    this.rechargeDate,
    this.commissionType,
    this.commissionAmount,
    this.commissionDate,
  });

  EarningItem.fromJson(Map<String, dynamic> json) {
    rechargeId = json['recharge_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    productId = json['product_id'];
    amount = json['amount'];
    status = json['status'];
    rechargeDate = json['recharge_date'];
    commissionType = json['commission_type'];
    commissionAmount = json['commission_amount'];
    commissionDate = json['commission_date'];
  }

  Map<String, dynamic> toJson() {
    return {
      'recharge_id': rechargeId,
      'user_name': userName,
      'mobile': mobile,
      'product_id': productId,
      'amount': amount,
      'status': status,
      'recharge_date': rechargeDate,
      'commission_type': commissionType,
      'commission_amount': commissionAmount,
      'commission_date': commissionDate,
    };
  }
}