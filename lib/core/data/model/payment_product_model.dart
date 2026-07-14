class CashbackProductType {
  bool? success;
  List<CashbackProductData>? data;
  String? message;
  int? code;

  CashbackProductType({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  CashbackProductType.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    if (json['data'] != null) {
      data = <CashbackProductData>[];
      json['data'].forEach((v) {
        data!.add(CashbackProductData.fromJson(v));
      });
    }

    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};

    map['success'] = success;

    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }

    map['message'] = message;
    map['code'] = code;

    return map;
  }
}

class CashbackProductData {
  int? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  CashbackProductData({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  CashbackProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}