class PaymentStatus {
  bool? success;
  List<PaymentStatusData>? data;
  String? message;
  int? code;

  PaymentStatus({this.success, this.data, this.message, this.code});

  PaymentStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PaymentStatusData>[];
      json['data'].forEach((v) {
        data!.add(PaymentStatusData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class PaymentStatusData {
  int? id;
  String? dateTime;
  String? productName;
  String? productLogo;
  String? transactionNo;
  String? mobile;
  String? amount;
  String? paymentStatus;

  PaymentStatusData({
    this.id,
    this.dateTime,
    this.productName,
    this.productLogo,
    this.transactionNo,
    this.mobile,
    this.amount,
    this.paymentStatus,
  });

  PaymentStatusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['date_time'];
    productName = json['product_name'];
    productLogo = json['product_logo'];
    transactionNo = json['transaction_no']?.toString();
    mobile = json['mobile']?.toString();
    amount = json['amount']?.toString();
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_time'] = dateTime;
    data['product_name'] = productName;
    data['product_logo'] = productLogo;
    data['transaction_no'] = transactionNo;
    data['mobile'] = mobile;
    data['amount'] = amount;
    data['payment_status'] = paymentStatus;
    return data;
  }
}
