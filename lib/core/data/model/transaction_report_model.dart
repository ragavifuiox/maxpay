// // class TransactionReport {
// //   bool? success;
// //   List<TransrepData>? data;
// //   String? message;
// //   int? code;

// //   TransactionReport({this.success, this.data, this.message, this.code});

// //   TransactionReport.fromJson(Map<String, dynamic> json) {
// //     success = json['success'];
// //     if (json['data'] != null) {
// //       data = <TransrepData>[];
// //       json['data'].forEach((v) {
// //         data!.add(TransrepData.fromJson(v));
// //       });
// //     }
// //     message = json['message'];
// //     code = json['code'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['success'] = success;
// //     if (this.data != null) {
// //       data['data'] = this.data!.map((v) => v.toJson()).toList();
// //     }
// //     data['message'] = message;
// //     data['code'] = code;
// //     return data;
// //   }
// // }

// // class TransrepData {
// //   String? transactionId;
// //   String? operator;
// //   String? mobile;
// //   String? amount;
// //   String? status;
// //   String? dateTime;
// //   String? logo;

// //   TransrepData(
// //       {this.transactionId,
// //       this.operator,
// //       this.mobile,
// //       this.amount,
// //       this.status,
// //       this.dateTime,
// //       this.logo});

// //   TransrepData.fromJson(Map<String, dynamic> json) {
// //     transactionId = json['transaction_id'];
// //     operator = json['operator'];
// //     mobile = json['mobile'];
// //     amount = json['amount'];
// //     status = json['status'];
// //     dateTime = json['date_time'];
// //     logo = json['logo'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['transaction_id'] = transactionId;
// //     data['operator'] = operator;
// //     data['mobile'] = mobile;
// //     data['amount'] = amount;
// //     data['status'] = status;
// //     data['date_time'] = dateTime;
// //     data['logo'] = logo;
// //     return data;
// //   }
// // }




// class TransactionReport {
//   bool? success;
//   List<TransrepData>? data;
//   String? message;
//   int? code;

//   TransactionReport({this.success, this.data, this.message, this.code});

//   TransactionReport.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <TransrepData>[];
//       json['data'].forEach((v) {
//         data!.add(TransrepData.fromJson(v));
//       });
//     }
//     message = json['message'];
//     code = json['code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = message;
//     data['code'] = code;
//     return data;
//   }
// }

// class TransrepData {
//   int? id;
//   String? transactionId;
//   String? operator;
//   String? mobile;
//   String? amount;
//   String? status;
//   String? dateTime;
//   String? logo;
//   String? producttype;

//   TransrepData(
//       {this.id,
//       this.transactionId,
//       this.operator,
//       this.mobile,
//       this.amount,
//       this.status,
//       this.dateTime,
//       this.logo,
//       this.producttype});

//   TransrepData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     transactionId = json['transaction_id'];
//     producttype = json['product_type'];
//     operator = json['operator'];
//     mobile = json['mobile'];
//     amount = json['amount'];
//     status = json['status'];
//     dateTime = json['date_time'];
//     logo = json['logo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['transaction_id'] = transactionId;
//     data['operator'] = operator;
//     data['mobile'] = mobile;
//     data['amount'] = amount;
//     data['status'] = status;
//     data['date_time'] = dateTime;
//     data['logo'] = logo;
//     data['producttype'] =producttype;
//     return data;
//   }
// }




class TransactionReport {
  bool? success;
  List<TransrepData>? data;
  String? message;
  int? code;

  TransactionReport({this.success, this.data, this.message, this.code});

  TransactionReport.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TransrepData>[];
      json['data'].forEach((v) {
        data!.add(TransrepData.fromJson(v));
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

class TransrepData {
  int? id;
  int? productId;
  String? productTypeId;
  String? productType;
  String? productName;
  String? productLogo;
  String? paymentStatus;
  String? transactionNo;
  String? mobile;
  String? availableBalance;
  String? transactionAmount;
  String? commission;
  String? surcharge;
  String? remainingBalance;
  String? requestDateTime;
  String? responseDateTime;
  String? transactionId;
  String? operator;
  String? amount;
  String? status;
  String? dateTime;
  String? logo;
  String? url;

  TransrepData(
      {this.id,
      this.productId,
      this.productTypeId,
      this.productType,
      this.productName,
      this.productLogo,
      this.paymentStatus,
      this.transactionNo,
      this.mobile,
      this.availableBalance,
      this.transactionAmount,
      this.commission,
      this.surcharge,
      this.remainingBalance,
      this.requestDateTime,
      this.responseDateTime,
      this.transactionId,
      this.operator,
      this.amount,
      this.status,
      this.dateTime,
      this.url,
      this.logo});

  TransrepData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productTypeId = json['product_type_id'];
    productType = json['product_type'];
    productName = json['product_name'];
    productLogo = json['product_logo'];
    paymentStatus = json['payment_status'];
    transactionNo = json['transaction_no'];
    mobile = json['mobile'];
    availableBalance = json['available_balance'];
    transactionAmount = json['transaction_amount'];
    commission = json['commission'];
    surcharge = json['surcharge'];
    remainingBalance = json['remaining_balance'];
    requestDateTime = json['request_date_time'];
    responseDateTime = json['response_date_time'];
    transactionId = json['transaction_id'];
    operator = json['operator'];
    amount = json['amount'];
    status = json['status'];
    dateTime = json['date_time'];
    logo = json['logo'];
    url = json['receipt_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_type_id'] = productTypeId;
    data['product_type'] = productType;
    data['product_name'] = productName;
    data['product_logo'] = productLogo;
    data['payment_status'] = paymentStatus;
    data['transaction_no'] = transactionNo;
    data['mobile'] = mobile;
    data['available_balance'] = availableBalance;
    data['transaction_amount'] = transactionAmount;
    data['commission'] = commission;
    data['surcharge'] = surcharge;
    data['remaining_balance'] = remainingBalance;
    data['request_date_time'] = requestDateTime;
    data['response_date_time'] = responseDateTime;
    data['transaction_id'] = transactionId;
    data['operator'] = operator;
    data['amount'] = amount;
    data['status'] = status;
    data['date_time'] = dateTime;
    data['logo'] = logo;
    data['receipt_url'] = url;
    return data;
  }
}
