class CustomerInfo {
  bool? status;
  Data? data;

  CustomerInfo({this.status, this.data});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Null tel;
  String? operator;
  List<Records>? records;
  int? status;

  Data({this.tel, this.operator, this.records, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    tel = json['tel'];
    operator = json['operator'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tel'] = tel;
    data['operator'] = operator;
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Records {
  String? monthlyrecharge;
  String? balance;
  String? customername;
  String? status;
  String? nextrechargedate;
  String? lastrechargedate;
  String? lastrechargeamount;
  String? planname;

  Records(
      {this.monthlyrecharge,
      this.balance,
      this.customername,
      this.status,
      this.nextrechargedate,
      this.lastrechargedate,
      this.lastrechargeamount,
      this.planname});

 Records.fromJson(Map<String, dynamic> json) {
  monthlyrecharge = json['MonthlyRecharge']?.toString();
  balance = json['Balance']?.toString();
  customername = json['customerName']?.toString();
  status = json['status']?.toString();
  nextrechargedate = json['NextRechargeDate']?.toString();
  lastrechargedate = json['LastRechargeDate']?.toString();
  lastrechargeamount = json['lastrechargeamount']?.toString();
  planname = json['planname']?.toString();
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['monthlyrecharge'] = monthlyrecharge;
    data['balance'] = balance;
    data['customername'] = customername;
    data['status'] = status;
    data['nextrechargedate'] = nextrechargedate;
    data['lastrechargedate'] = lastrechargedate;
    data['lastrechargeamount'] = lastrechargeamount;
    data['planname'] = planname;
    return data;
  }
}
