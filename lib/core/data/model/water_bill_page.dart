class WaterBill {
  bool? success;
  String? message;
  Errors? errors;
  int? code;

  WaterBill({this.success, this.message, this.errors, this.code});

  WaterBill.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Errors {
  int? productId;
  String? customerId;
  String? lastApiError;

  Errors({this.productId, this.customerId, this.lastApiError});

  Errors.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    customerId = json['customer_id'];
    lastApiError = json['last_api_error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    data['last_api_error'] = this.lastApiError;
    return data;
  }
}
