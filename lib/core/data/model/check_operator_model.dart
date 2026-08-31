class CheckOperator {
  bool? status;
  String? message;
  String? operator;
  int? operatorCode;
  Null circle;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['operator'] = operator;
    data['operator_code'] = operatorCode;
    data['circle'] = circle;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['logo'] = logo;
    data['source'] = source;
    return data;
  }
}
