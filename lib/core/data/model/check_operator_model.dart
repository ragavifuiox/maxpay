class CheckOperator {
  bool? status;
  String? message;
  String? operator;
  int? operatorCode;
  Null? circle;
  int? productId;
  String? productName;
  String? logo;
  String? source;

  CheckOperator(
      {this.status,
      this.message,
      this.operator,
      this.operatorCode,
      this.circle,
      this.productId,
      this.productName,
      this.logo,
      this.source});

  CheckOperator.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    operator = json['operator'];
    operatorCode = json['operator_code'];
    circle = json['circle'];
    productId = json['product_id'];
    productName = json['product_name'];
    logo = json['logo'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['operator'] = this.operator;
    data['operator_code'] = this.operatorCode;
    data['circle'] = this.circle;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['logo'] = this.logo;
    data['source'] = this.source;
    return data;
  }
}
