

import 'dart:ffi';

class CheckOperator {
  bool? status;
  Lookup? lookup;
  bool? productFound;
  Product? product;

  CheckOperator({this.status, this.lookup, this.productFound, this.product});

  CheckOperator.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    lookup =
        json['lookup'] != null ? new Lookup.fromJson(json['lookup']) : null;
    productFound = json['product_found'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.lookup != null) {
      data['lookup'] = this.lookup!.toJson();
    }
    data['product_found'] = this.productFound;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Lookup {
  int? status;
  String? mobileNumber;
  Records? records;
  double? time;

  Lookup({this.status, this.mobileNumber, this.records, this.time});

  Lookup.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mobileNumber = json['mobile_number'];
    records =
        json['records'] != null ? new Records.fromJson(json['records']) : null;
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['mobile_number'] = this.mobileNumber;
    if (this.records != null) {
      data['records'] = this.records!.toJson();
    }
    data['time'] = this.time;
    return data;
  }
}

class Records {
  int? status;
  String? operator;
  String? segment;
  String? circle;
  String? comcircle;
  int? operatorCode;
  int? circleCode;

  Records(
      {this.status,
      this.operator,
      this.segment,
      this.circle,
      this.comcircle,
      this.operatorCode,
      this.circleCode});

  Records.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    operator = json['Operator'];
    segment = json['segment'];
    circle = json['circle'];
    comcircle = json['comcircle'];
    operatorCode = json['OperatorCode'];
    circleCode = json['CircleCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['Operator'] = this.operator;
    data['segment'] = this.segment;
    data['circle'] = this.circle;
    data['comcircle'] = this.comcircle;
    data['OperatorCode'] = this.operatorCode;
    data['CircleCode'] = this.circleCode;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;

  Product({this.id, this.name, this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
