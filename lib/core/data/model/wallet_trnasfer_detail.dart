class WalletTransferDetail {
  bool? success;
  TransferData? data;
  String? message;
  int? code;

  WalletTransferDetail({this.success, this.data, this.message, this.code});

  WalletTransferDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? TransferData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
      'code': code,
    };
  }
}

class TransferData {
  String? transactionType;
  String? totalAmount;
  int? count;
  List<TransferHistory>? history;

  TransferData({
    this.transactionType,
    this.totalAmount,
    this.count,
    this.history,
  });

  TransferData.fromJson(Map<String, dynamic> json) {
    transactionType = json['transaction_type'];
    totalAmount = json['total_amount'];
    count = json['count'];

    if (json['history'] != null) {
      history = <TransferHistory>[];
      json['history'].forEach((v) {
        history!.add(TransferHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_type': transactionType,
      'total_amount': totalAmount,
      'count': count,
      'history': history?.map((e) => e.toJson()).toList(),
    };
  }
}

class TransferHistory {
  int? id;
  String? retailerId;
  String? staffId;
  String? paymentType;
  String? amount;
  String? txnId;
  String? createdAt;
  String? updatedAt;
  String? userType;
  String? name;
  String? mobileNumber;
  String? status;

  TransferHistory({
    this.id,
    this.retailerId,
    this.staffId,
    this.paymentType,
    this.amount,
    this.txnId,
    this.createdAt,
    this.updatedAt,
    this.userType,
    this.name,
    this.mobileNumber,
    this.status,
  });

  TransferHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerId = json['retailer_id'];
    staffId = json['staff_id'];
    paymentType = json['payment_type'];
    amount = json['amount'];
    txnId = json['txn_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'retailer_id': retailerId,
      'staff_id': staffId,
      'payment_type': paymentType,
      'amount': amount,
      'txn_id': txnId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_type': userType,
      'name': name,
      'mobile_number': mobileNumber,
      'status': status,
    };
  }

  double get amountValue => double.tryParse(amount ?? '0') ?? 0.0;

  DateTime? get createdAtDate =>
      createdAt != null ? DateTime.tryParse(createdAt!) : null;
}
