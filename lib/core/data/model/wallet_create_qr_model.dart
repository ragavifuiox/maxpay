// import 'dart:convert';

// CreateQrResponse createQrResponseFromJson(String str) =>
//     CreateQrResponse.fromJson(json.decode(str));

// String createQrResponseToJson(CreateQrResponse data) =>
//     json.encode(data.toJson());

// class CreateQrResponse {
//   bool? status;
//   String? txnId;
//   String? amount;
//   String? upiLink;
//   String? gpayLink;
//   String? phonepeLink;
//   dynamic qrImage;

//   CreateQrResponse({
//     this.status,
//     this.txnId,
//     this.amount,
//     this.upiLink,
//     this.gpayLink,
//     this.phonepeLink,
//     this.qrImage,
//   });

//   CreateQrResponse copyWith({
//     bool? status,
//     String? txnId,
//     String? amount,
//     String? upiLink,
//     String? gpayLink,
//     String? phonepeLink,
//     dynamic qrImage,
//   }) => CreateQrResponse(
//     status: status ?? this.status,
//     txnId: txnId ?? this.txnId,
//     amount: amount ?? this.amount,
//     upiLink: upiLink ?? this.upiLink,
//     gpayLink: gpayLink ?? this.gpayLink,
//     phonepeLink: phonepeLink ?? this.phonepeLink,
//     qrImage: qrImage ?? this.qrImage,
//   );

//   factory CreateQrResponse.fromJson(Map<String, dynamic> json) =>
//       CreateQrResponse(
//         status: json["status"],
//         txnId: json["txn_id"],
//         amount: json["amount"],
//         upiLink: json["upi_link"],
//         gpayLink: json["gpay_link"],
//         phonepeLink: json["phonepe_link"],
//         qrImage: json["qr_image"],
//       );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "txn_id": txnId,
//     "amount": amount,
//     "upi_link": upiLink,
//     "gpay_link": gpayLink,
//     "phonepe_link": phonepeLink,
//     "qr_image": qrImage,
//   };
// }

// To parse this JSON data, do
//
//     final createQrResponse = createQrResponseFromJson(jsonString);

import 'dart:convert';

CreateQrResponse createQrResponseFromJson(String str) => CreateQrResponse.fromJson(json.decode(str));

String createQrResponseToJson(CreateQrResponse data) => json.encode(data.toJson());

class CreateQrResponse {
    bool? status;
    String? amount;
    Ekqr? ekqr;
    Worldline? worldline;

    CreateQrResponse({
        this.status,
        this.amount,
        this.ekqr,
        this.worldline,
    });

    factory CreateQrResponse.fromJson(Map<String, dynamic> json) => CreateQrResponse(
        status: json["status"],
        amount: json["amount"],
        ekqr: json["ekqr"] == null ? null : Ekqr.fromJson(json["ekqr"]),
        worldline: json["worldline"] == null ? null : Worldline.fromJson(json["worldline"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "amount": amount,
        "ekqr": ekqr?.toJson(),
        "worldline": worldline?.toJson(),
    };
}

class Ekqr {
    bool? status;
    String? txnId;
    String? amount;
    String? upiLink;
    dynamic qrImage;

    Ekqr({
        this.status,
        this.txnId,
        this.amount,
        this.upiLink,
        this.qrImage,
    });

    factory Ekqr.fromJson(Map<String, dynamic> json) => Ekqr(
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

class Worldline {
    bool? status;
    String? txnId;
    String? amount;
    Data? data;

    Worldline({
        this.status,
        this.txnId,
        this.amount,
        this.data,
    });

    factory Worldline.fromJson(Map<String, dynamic> json) => Worldline(
        status: json["status"],
        txnId: json["txn_id"],
        amount: json["amount"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "txn_id": txnId,
        "amount": amount,
        "data": data?.toJson(),
    };
}

class Data {
    String? merchantId;
    String? token;
    String? deviceId;
    String? consumerId;
    String? consumerMobileNo;
    String? consumerEmailId;
    String? txnId;
    String? currency;
    String? paymentMode;
    List<Item>? items;

    Data({
        this.merchantId,
        this.token,
        this.deviceId,
        this.consumerId,
        this.consumerMobileNo,
        this.consumerEmailId,
        this.txnId,
        this.currency,
        this.paymentMode,
        this.items,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        merchantId: json["merchantId"],
        token: json["token"],
        deviceId: json["deviceId"],
        consumerId: json["consumerId"],
        consumerMobileNo: json["consumerMobileNo"],
        consumerEmailId: json["consumerEmailId"],
        txnId: json["txnId"],
        currency: json["currency"],
        paymentMode: json["paymentMode"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "merchantId": merchantId,
        "token": token,
        "deviceId": deviceId,
        "consumerId": consumerId,
        "consumerMobileNo": consumerMobileNo,
        "consumerEmailId": consumerEmailId,
        "txnId": txnId,
        "currency": currency,
        "paymentMode": paymentMode,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    String? itemId;
    String? amount;
    String? comAmt;

    Item({
        this.itemId,
        this.amount,
        this.comAmt,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["itemId"],
        amount: json["amount"],
        comAmt: json["comAmt"],
    );

    Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "amount": amount,
        "comAmt": comAmt,
    };
}
