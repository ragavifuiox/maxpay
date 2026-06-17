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
        data!.add(new PaymentStatusData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class PaymentStatusData {
  int? id;
  String? dateTime;
  String? productName;
  String? productLogo;
  Null? transactionNo;
  String? mobile;
  String? amount;
  String? paymentStatus;

  PaymentStatusData(
      {this.id,
      this.dateTime,
      this.productName,
      this.productLogo,
      this.transactionNo,
      this.mobile,
      this.amount,
      this.paymentStatus});

  PaymentStatusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['date_time'];
    productName = json['product_name'];
    productLogo = json['product_logo'];
    transactionNo = json['transaction_no'];
    mobile = json['mobile'];
    amount = json['amount'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_time'] = this.dateTime;
    data['product_name'] = this.productName;
    data['product_logo'] = this.productLogo;
    data['transaction_no'] = this.transactionNo;
    data['mobile'] = this.mobile;
    data['amount'] = this.amount;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}
