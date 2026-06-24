class CashBack {
  bool? success;
  bool? data;
  String? message;
  List<Code>? code;

  CashBack({this.success, this.data, this.message, this.code});

  CashBack.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    if (json['code'] != null) {
      code = <Code>[];
      json['code'].forEach((v) {
        code!.add(Code.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    if (code != null) {
      data['code'] = code!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Code {
  int? productId;
  String? name;
  String? logo;
  String? debitCommission;

  Code({this.productId, this.name, this.logo, this.debitCommission});

  Code.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    logo = json['logo'];
    debitCommission = json['debit_commission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['logo'] = logo;
    data['debit_commission'] = debitCommission;
    return data;
  }
}
