import 'dart:convert';

WalletQrHistory walletQrHistoryFromJson(String str) =>
    WalletQrHistory.fromJson(json.decode(str));

String walletQrHistoryToJson(WalletQrHistory data) =>
    json.encode(data.toJson());

class WalletQrHistory {
  bool? success;
  String? message;
  List<Code>? data;

  WalletQrHistory({
    this.success,
    this.message,
    this.data,
  });

  WalletQrHistory copyWith({
    bool? success,
    String? message,
    List<Code>? data,
  }) {
    return WalletQrHistory(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory WalletQrHistory.fromJson(Map<String, dynamic> json) {
    return WalletQrHistory(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Code>.from(
              json["data"].map((x) => Code.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data == null
          ? []
          : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
  }
}

class Code {
  int? id;
  int? retailerId;
  String? userType;
  String? paymentMode;
  String? retailerUserId;
  String? txnId;
  String? requestAmount;
  String? status;
  String? walletType;
  DateTime? createdAt;
  DateTime? updatedAt;

  Code({
    this.id,
    this.retailerId,
    this.userType,
    this.paymentMode,
    this.retailerUserId,
    this.txnId,
    this.requestAmount,
    this.status,
    this.walletType,
    this.createdAt,
    this.updatedAt,
  });

  Code copyWith({
    int? id,
    int? retailerId,
    String? userType,
    String? paymentMode,
    String? retailerUserId,
    String? txnId,
    String? requestAmount,
    String? status,
    String? walletType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Code(
      id: id ?? this.id,
      retailerId: retailerId ?? this.retailerId,
      userType: userType ?? this.userType,
      paymentMode: paymentMode ?? this.paymentMode,
      retailerUserId: retailerUserId ?? this.retailerUserId,
      txnId: txnId ?? this.txnId,
      requestAmount: requestAmount ?? this.requestAmount,
      status: status ?? this.status,
      walletType: walletType ?? this.walletType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      id: json["id"],
      retailerId: json["retailer_id"],
      userType: json["user_type"]?.toString(),
      paymentMode: json["payment_mode"]?.toString(),
      retailerUserId: json["retailer_user_id"]?.toString(),
      txnId: json["txn_id"]?.toString(),
      requestAmount: json["request_amount"]?.toString(),
      status: json["status"]?.toString(),
      walletType: json["wallet_type"]?.toString(),
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"].toString())
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.tryParse(json["updated_at"].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "retailer_id": retailerId,
      "user_type": userType,
      "payment_mode": paymentMode,
      "retailer_user_id": retailerUserId,
      "txn_id": txnId,
      "request_amount": requestAmount,
      "status": status,
      "wallet_type": walletType,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}