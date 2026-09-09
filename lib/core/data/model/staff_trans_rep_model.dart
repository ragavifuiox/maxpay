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
        data!.add(StaffReportData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_id'] = transactionId;
    data['retailer_name'] = retailerName;
    data['operator'] = operator;
    data['mobile'] = mobile;
    data['amount'] = amount;
    data['status'] = status;
    data['date_time'] = dateTime;
    data['logo'] = logo;
    return data;
  }
}
