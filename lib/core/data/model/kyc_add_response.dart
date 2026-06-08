// To parse this JSON data, do
//
//     final kycAddResponse = kycAddResponseFromJson(jsonString);

import 'dart:convert';

KycAddResponse kycAddResponseFromJson(String str) => KycAddResponse.fromJson(json.decode(str));

String kycAddResponseToJson(KycAddResponse data) => json.encode(data.toJson());

class KycAddResponse {
    bool? success;
    Data? data;
    String? message;
    int? code;

    KycAddResponse({
        this.success,
        this.data,
        this.message,
        this.code,
    });

    KycAddResponse copyWith({
        bool? success,
        Data? data,
        String? message,
        int? code,
    }) => 
        KycAddResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
            code: code ?? this.code,
        );

    factory KycAddResponse.fromJson(Map<String, dynamic> json) => KycAddResponse(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
        "code": code,
    };
}

class Data {
    int? kycId;
    int? retailerId;
    String? email;
    String? address;
    String? gstNo;
    String? pan;

    Data({
        this.kycId,
        this.retailerId,
        this.email,
        this.address,
        this.gstNo,
        this.pan,
    });

    Data copyWith({
        int? kycId,
        int? retailerId,
        String? email,
        String? address,
        String? gstNo,
        String? pan,
    }) => 
        Data(
            kycId: kycId ?? this.kycId,
            retailerId: retailerId ?? this.retailerId,
            email: email ?? this.email,
            address: address ?? this.address,
            gstNo: gstNo ?? this.gstNo,
            pan: pan ?? this.pan,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        kycId: json["kyc_id"],
        retailerId: json["retailer_id"],
        email: json["email"],
        address: json["address"],
        gstNo: json["gst_no"],
        pan: json["pan"],
    );

    Map<String, dynamic> toJson() => {
        "kyc_id": kycId,
        "retailer_id": retailerId,
        "email": email,
        "address": address,
        "gst_no": gstNo,
        "pan": pan,
    };
}
