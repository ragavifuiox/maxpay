class Stafftransrep {
  bool? success;
  List<StaffReportData>? data;
  String? message;
  int? code;

  Stafftransrep({this.success, this.data, this.message, this.code});

  Stafftransrep.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <StaffReportData>[];
      json['data'].forEach((v) {
        data!.add(new StaffReportData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class StaffReportData {
  int? id;
  String? transactionId;
  String? retailerName;
  String? operator;
  String? mobile;
  String? amount;
  String? status;
  String? dateTime;
  String? logo;

  StaffReportData(
      {this.id,
      this.transactionId,
      this.retailerName,
      this.operator,
      this.mobile,
      this.amount,
      this.status,
      this.dateTime,
      this.logo});

  StaffReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    retailerName = json['retailer_name'];
    operator = json['operator'];
    mobile = json['mobile'];
    amount = json['amount'];
    status = json['status'];
    dateTime = json['date_time'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['retailer_name'] = this.retailerName;
    data['operator'] = this.operator;
    data['mobile'] = this.mobile;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['date_time'] = this.dateTime;
    data['logo'] = this.logo;
    return data;
  }
}
