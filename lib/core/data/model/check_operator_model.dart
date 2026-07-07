class CheckOperator {
  bool? status;
  Lookup? lookup;
  Product? product;

  CheckOperator({
    this.status,
    this.lookup,
    this.product,
  });

  CheckOperator.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    lookup =
        json['lookup'] != null ? Lookup.fromJson(json['lookup']) : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'lookup': lookup?.toJson(),
      'product': product?.toJson(),
    };
  }
}

class Lookup {
  String? tel;
  Records? records;
  String? status;

  Lookup({
    this.tel,
    this.records,
    this.status,
  });

  Lookup.fromJson(Map<String, dynamic> json) {
    tel = json['tel']?.toString();
    records =
        json['records'] != null ? Records.fromJson(json['records']) : null;
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'tel': tel,
      'records': records?.toJson(),
      'status': status,
    };
  }
}

class Records {
  String? status;
  String? operator;
  String? circle;
  String? comcircle;
  int? circlecode;

  Records({
    this.status,
    this.operator,
    this.circle,
    this.comcircle,
    this.circlecode,
  });

  Records.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    operator = json['operator']?.toString();
    circle = json['circle']?.toString();
    comcircle = json['comcircle']?.toString();
    circlecode = json['circlecode'] is int
        ? json['circlecode']
        : int.tryParse(json['circlecode'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'operator': operator,
      'circle': circle,
      'comcircle': comcircle,
      'circlecode': circlecode,
    };
  }
}

class Product {
  int? id;
  String? name;
  String? description;

  Product({
    this.id,
    this.name,
    this.description,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id'].toString());

    name = json['name']?.toString();
    description = json['description']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}