class InstantPay {
  bool? success;
  Data? data;
  String? message;
  int? code;

  InstantPay({this.success, this.data, this.message, this.code});

  InstantPay.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  Bill? bill;
  String? source;
  String? billerId;
  String? productCode;
  int? apiId;
  int? mappingId;
  Product? product;
  String? debugId;

  Data(
      {this.bill,
      this.source,
      this.billerId,
      this.productCode,
      this.apiId,
      this.mappingId,
      this.product,
      this.debugId});

  Data.fromJson(Map<String, dynamic> json) {
    bill = json['bill'] != null ? new Bill.fromJson(json['bill']) : null;
    source = json['source'];
    billerId = json['biller_id'];
    productCode = json['product_code'];
    apiId = json['api_id'];
    mappingId = json['mapping_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    debugId = json['debug_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bill != null) {
      data['bill'] = this.bill!.toJson();
    }
    data['source'] = this.source;
    data['biller_id'] = this.billerId;
    data['product_code'] = this.productCode;
    data['api_id'] = this.apiId;
    data['mapping_id'] = this.mappingId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['debug_id'] = this.debugId;
    return data;
  }
}

class Bill {
  String? customerName;
  String? billNumber;
  String? billDate;
  String? billDueDate;
  int? amount;
  int? billAmount;
  bool? hasDueAmount;
  String? customerNumber;
  String? enquiryReference;
  int? apiId;
  int? mappingId;
  String? billerId;
  int? daysLeft;

  Bill(
      {this.customerName,
      this.billNumber,
      this.billDate,
      this.billDueDate,
      this.amount,
      this.billAmount,
      this.hasDueAmount,
      this.customerNumber,
      this.enquiryReference,
      this.apiId,
      this.mappingId,
      this.billerId,
      this.daysLeft});

  Bill.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    billNumber = json['bill_number'];
    billDate = json['bill_date'];
    billDueDate = json['bill_due_date'];
    amount = json['amount'];
    billAmount = json['bill_amount'];
    hasDueAmount = json['has_due_amount'];
    customerNumber = json['customer_number'];
    enquiryReference = json['enquiry_reference'];
    apiId = json['api_id'];
    mappingId = json['mapping_id'];
    billerId = json['biller_id'];
    daysLeft = json['days_left'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;
    data['bill_number'] = this.billNumber;
    data['bill_date'] = this.billDate;
    data['bill_due_date'] = this.billDueDate;
    data['amount'] = this.amount;
    data['bill_amount'] = this.billAmount;
    data['has_due_amount'] = this.hasDueAmount;
    data['customer_number'] = this.customerNumber;
    data['enquiry_reference'] = this.enquiryReference;
    data['api_id'] = this.apiId;
    data['mapping_id'] = this.mappingId;
    data['biller_id'] = this.billerId;
    data['days_left'] = this.daysLeft;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? logo;

  Product({this.id, this.name, this.logo});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
  
}
