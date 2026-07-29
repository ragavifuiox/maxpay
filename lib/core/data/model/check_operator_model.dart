// class CheckOperator {
//   bool? status;
//   Lookup? lookup;
//   Product? product;

//   CheckOperator({
//     this.status,
//     this.lookup,
//     this.product,
//   });

//   CheckOperator.fromJson(Map<String, dynamic> json) {
//     status = json['status'] as bool?;
//     lookup =
//         json['lookup'] != null ? Lookup.fromJson(json['lookup']) : null;
//     product =
//         json['product'] != null ? Product.fromJson(json['product']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'lookup': lookup?.toJson(),
//       'product': product?.toJson(),
//     };
//   }
// }

// class Lookup {
//   String? tel;
//   Records? records;
//   String? status;

//   Lookup({
//     this.tel,
//     this.records,
//     this.status,
//   });

//   Lookup.fromJson(Map<String, dynamic> json) {
//     tel = json['tel']?.toString();
//     records =
//         json['records'] != null ? Records.fromJson(json['records']) : null;
//     status = json['status']?.toString();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'tel': tel,
//       'records': records?.toJson(),
//       'status': status,
//     };
//   }
// }

// class Records {
//   String? status;
//   String? operator;
//   String? circle;
//   String? comcircle;
//   int? circlecode;

//   Records({
//     this.status,
//     this.operator,
//     this.circle,
//     this.comcircle,
//     this.circlecode,
//   });

//   Records.fromJson(Map<String, dynamic> json) {
//     status = json['status']?.toString();
//     operator = json['operator']?.toString();
//     circle = json['circle']?.toString();
//     comcircle = json['comcircle']?.toString();
//     circlecode = json['circlecode'] is int
//         ? json['circlecode']
//         : int.tryParse(json['circlecode'].toString());
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'operator': operator,
//       'circle': circle,
//       'comcircle': comcircle,
//       'circlecode': circlecode,
//     };
//   }
// }

// class Product {
//   int? id;
//   String? name;
//   String? description;

//   Product({
//     this.id,
//     this.name,
//     this.description,
//   });

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'] is int
//         ? json['id']
//         : int.tryParse(json['id'].toString());

//     name = json['name']?.toString();
//     description = json['description']?.toString();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//     };
//   }
// }


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
  Null id;
  Null name;
  Null description;

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
