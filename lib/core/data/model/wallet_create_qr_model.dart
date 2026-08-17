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
  String? gpayLink;
  String? phonepeLink;
  dynamic qrImage;

  CreateQrResponse({
    this.status,
    this.txnId,
    this.amount,
    this.upiLink,
    this.gpayLink,
    this.phonepeLink,
    this.qrImage,
  });

  CreateQrResponse copyWith({
    bool? status,
    String? txnId,
    String? amount,
    String? upiLink,
    String? gpayLink,
    String? phonepeLink,
    dynamic qrImage,
  }) => CreateQrResponse(
    status: status ?? this.status,
    txnId: txnId ?? this.txnId,
    amount: amount ?? this.amount,
    upiLink: upiLink ?? this.upiLink,
    gpayLink: gpayLink ?? this.gpayLink,
    phonepeLink: phonepeLink ?? this.phonepeLink,
    qrImage: qrImage ?? this.qrImage,
  );

  factory CreateQrResponse.fromJson(Map<String, dynamic> json) =>
      CreateQrResponse(
        status: json["status"],
        txnId: json["txn_id"],
        amount: json["amount"],
        upiLink: json["upi_link"],
        gpayLink: json["gpay_link"],
        phonepeLink: json["phonepe_link"],
        qrImage: json["qr_image"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "txn_id": txnId,
    "amount": amount,
    "upi_link": upiLink,
    "gpay_link": gpayLink,
    "phonepe_link": phonepeLink,
    "qr_image": qrImage,
  };
}