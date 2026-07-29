

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
        json['lookup'] != null ? Lookup.fromJson(json['lookup']) : null;
    productFound = json['product_found'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (lookup != null) {
      data['lookup'] = lookup!.toJson();
    }
    data['product_found'] = productFound;
    if (product != null) {
      data['product'] = product!.toJson();
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
        json['records'] != null ? Records.fromJson(json['records']) : null;
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['mobile_number'] = mobileNumber;
    if (records != null) {
      data['records'] = records!.toJson();
    }
    data['time'] = time;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['Operator'] = operator;
    data['segment'] = segment;
    data['circle'] = circle;
    data['comcircle'] = comcircle;
    data['OperatorCode'] = operatorCode;
    data['CircleCode'] = circleCode;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
