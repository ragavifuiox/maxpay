class SearchEarnings {
  bool? success;
  Data? data;
  String? message;
  int? code;

  SearchEarnings({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  SearchEarnings.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    data = json['data'] != null
        ? Data.fromJson(json['data'])
        : null;

    message = json['message'];

    code = json['code'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = {};

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

  String? totalEarnings;

  List<EarningItem>? list;

  Data({
    this.totalEarnings,
    this.list,
  });

  Data.fromJson(Map<String, dynamic> json) {

    totalEarnings =
        json['total_earnings'].toString();

    if (json['list'] != null) {

      list = <EarningItem>[];

      json['list'].forEach((v) {

        list!.add(
          EarningItem.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = {};

    data['total_earnings'] = totalEarnings;

    if (list != null) {

      data['list'] =
          list!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class EarningItem {

  int? rechargeId;
  String? mobile;
  String? amount;
  String? status;
  String? rechargeDate;
  String? commissionType;
  String? commissionAmount;
  String? commissionDate;

  EarningItem({
    this.rechargeId,
    this.mobile,
    this.amount,
    this.status,
    this.rechargeDate,
    this.commissionType,
    this.commissionAmount,
    this.commissionDate,
  });

  EarningItem.fromJson(Map<String, dynamic> json) {

    rechargeId = json['recharge_id'];

    mobile = json['mobile'];

    amount = json['amount'];

    status = json['status'];

    rechargeDate = json['recharge_date'];

    commissionType = json['commission_type'];

    commissionAmount = json['commission_amount'];

    commissionDate = json['commission_date'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = {};

    data['recharge_id'] = rechargeId;

    data['mobile'] = mobile;

    data['amount'] = amount;

    data['status'] = status;

    data['recharge_date'] = rechargeDate;

    data['commission_type'] = commissionType;

    data['commission_amount'] = commissionAmount;

    data['commission_date'] = commissionDate;

    return data;
  }
}