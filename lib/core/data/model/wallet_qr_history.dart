// To parse this JSON data, do
//
//     final walletQrHistory = walletQrHistoryFromJson(jsonString);

import 'dart:convert';

WalletQrHistory walletQrHistoryFromJson(String str) => WalletQrHistory.fromJson(json.decode(str));

String walletQrHistoryToJson(WalletQrHistory data) => json.encode(data.toJson());

class WalletQrHistory {
    bool? success;
    bool? data;
    String? message;
    List<Code>? code;

    WalletQrHistory({
        this.success,
        this.data,
        this.message,
        this.code,
    });

    WalletQrHistory copyWith({
        bool? success,
        bool? data,
        String? message,
        List<Code>? code,
    }) => 
        WalletQrHistory(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
            code: code ?? this.code,
        );

    factory WalletQrHistory.fromJson(Map<String, dynamic> json) => WalletQrHistory(
        success: json["success"],
        data: json["data"],
        message: json["message"],
        code: json["code"] == null ? [] : List<Code>.from(json["code"]!.map((x) => Code.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "message": message,
        "code": code == null ? [] : List<dynamic>.from(code!.map((x) => x.toJson())),
    };
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
    }) => 
        Code(
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

    factory Code.fromJson(Map<String, dynamic> json) => Code(
        id: json["id"],
        retailerId: json["retailer_id"],
        userType: json["user_type"],
        paymentMode: json["payment_mode"],
        retailerUserId: json["retailer_user_id"],
        txnId: json["txn_id"],
        requestAmount: json["request_amount"],
        status: json["status"],
        walletType: json["wallet_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
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
