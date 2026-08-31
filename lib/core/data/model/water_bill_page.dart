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
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    data['code'] = code;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['customer_id'] = customerId;
    data['last_api_error'] = lastApiError;
    return data;
  }
}
