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
        code!.add(new Code.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    if (this.code != null) {
      data['code'] = this.code!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['debit_commission'] = this.debitCommission;
    return data;
  }
}
