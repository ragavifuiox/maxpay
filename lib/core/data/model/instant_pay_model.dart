class InstantPay {
  bool? success;
  String? message;
  Errors? errors;
  int? code;

  InstantPay({this.success, this.message, this.errors, this.code});

  InstantPay.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Errors {
  String? billerId;
  String? productCode;
  Instantpay? instantpay;

  Errors({this.billerId, this.productCode, this.instantpay});

  Errors.fromJson(Map<String, dynamic> json) {
    billerId = json['biller_id'];
    productCode = json['product_code'];
    instantpay = json['instantpay'] != null
        ? new Instantpay.fromJson(json['instantpay'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['biller_id'] = this.billerId;
    data['product_code'] = this.productCode;
    if (this.instantpay != null) {
      data['instantpay'] = this.instantpay!.toJson();
    }
    return data;
  }
}

class Instantpay {
  String? statuscode;
  Null? actcode;
  String? status;
  Data? data;
  String? timestamp;
  String? ipayUuid;
  Null? orderid;
  String? environment;
  Null? internalCode;

  Instantpay(
      {this.statuscode,
      this.actcode,
      this.status,
      this.data,
      this.timestamp,
      this.ipayUuid,
      this.orderid,
      this.environment,
      this.internalCode});

  Instantpay.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    actcode = json['actcode'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
    ipayUuid = json['ipay_uuid'];
    orderid = json['orderid'];
    environment = json['environment'];
    internalCode = json['internalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['actcode'] = this.actcode;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = this.timestamp;
    data['ipay_uuid'] = this.ipayUuid;
    data['orderid'] = this.orderid;
    data['environment'] = this.environment;
    data['internalCode'] = this.internalCode;
    return data;
  }
}

class Data {
  Null? enquiryReferenceId;
  Null? customerName;
  Null? billNumber;
  Null? billPeriod;
  Null? billDate;
  Null? billDueDate;
  Null? billAmount;
  Null? customerParamsDetails;
  Null? billDetails;
  Null? additionalDetails;

  Data(
      {this.enquiryReferenceId,
      this.customerName,
      this.billNumber,
      this.billPeriod,
      this.billDate,
      this.billDueDate,
      this.billAmount,
      this.customerParamsDetails,
      this.billDetails,
      this.additionalDetails});

  Data.fromJson(Map<String, dynamic> json) {
    enquiryReferenceId = json['enquiryReferenceId'];
    customerName = json['CustomerName'];
    billNumber = json['BillNumber'];
    billPeriod = json['BillPeriod'];
    billDate = json['BillDate'];
    billDueDate = json['BillDueDate'];
    billAmount = json['BillAmount'];
    customerParamsDetails = json['CustomerParamsDetails'];
    billDetails = json['BillDetails'];
    additionalDetails = json['AdditionalDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiryReferenceId'] = this.enquiryReferenceId;
    data['CustomerName'] = this.customerName;
    data['BillNumber'] = this.billNumber;
    data['BillPeriod'] = this.billPeriod;
    data['BillDate'] = this.billDate;
    data['BillDueDate'] = this.billDueDate;
    data['BillAmount'] = this.billAmount;
    data['CustomerParamsDetails'] = this.customerParamsDetails;
    data['BillDetails'] = this.billDetails;
    data['AdditionalDetails'] = this.additionalDetails;
    return data;
  }
}
