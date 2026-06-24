// To parse this JSON data, do
//
//     final createQrResponse = createQrResponseFromJson(jsonString);

import 'dart:convert';

CreateQrResponse createQrResponseFromJson(String str) =>
    CreateQrResponse.fromJson(json.decode(str));

String createQrResponseToJson(CreateQrResponse data) =>
    json.encode(data.toJson());

class CreateQrResponse {
  bool? status;
  String? txnId;
  String? amount;
  String? upiLink;
  dynamic qrImage;

  CreateQrResponse({
    this.status,
    this.txnId,
    this.amount,
    this.upiLink,
    this.qrImage,
  });

  CreateQrResponse copyWith({
    bool? status,
    String? txnId,
    String? amount,
    String? upiLink,
    dynamic qrImage,
  }) => CreateQrResponse(
    status: status ?? this.status,
    txnId: txnId ?? this.txnId,
    amount: amount ?? this.amount,
    upiLink: upiLink ?? this.upiLink,
    qrImage: qrImage ?? this.qrImage,
  );

  factory CreateQrResponse.fromJson(Map<String, dynamic> json) =>
      CreateQrResponse(
        status: json["status"],
        txnId: json["txn_id"],
        amount: json["amount"],
        upiLink: json["upi_link"],
        qrImage: json["qr_image"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "txn_id": txnId,
    "amount": amount,
    "upi_link": upiLink,
    "qr_image": qrImage,
  };
}
