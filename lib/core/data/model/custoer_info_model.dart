class CustomerInfo {
  bool? status;
  Data? data;

  CustomerInfo({this.status, this.data});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Null? tel;
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
        records!.add(new Records.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tel'] = this.tel;
    data['operator'] = this.operator;
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
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
    monthlyrecharge = json['monthlyrecharge'];
    balance = json['balance'];
    customername = json['customername'];
    status = json['status'];
    nextrechargedate = json['nextrechargedate'];
    lastrechargedate = json['lastrechargedate'];
    lastrechargeamount = json['lastrechargeamount'];
    planname = json['planname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthlyrecharge'] = this.monthlyrecharge;
    data['balance'] = this.balance;
    data['customername'] = this.customername;
    data['status'] = this.status;
    data['nextrechargedate'] = this.nextrechargedate;
    data['lastrechargedate'] = this.lastrechargedate;
    data['lastrechargeamount'] = this.lastrechargeamount;
    data['planname'] = this.planname;
    return data;
  }
}
