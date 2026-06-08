// {
//     "success": true,
//     "data": {
//         "privacy_policy": "http://139.59.91.7/test_paylinkonline.in/public/privacy"
//     },
//     "message": "Privacy Policy fetched successfully",
//     "code": 200
// }

// To parse this JSON data, do
//
//     final privacyPolicyResponse = privacyPolicyResponseFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyResponse privacyPolicyResponseFromJson(String str) => PrivacyPolicyResponse.fromJson(json.decode(str));

String privacyPolicyResponseToJson(PrivacyPolicyResponse data) => json.encode(data.toJson());

class PrivacyPolicyResponse {
    bool? success;
    Data? data;
    String? message;
    int? code;

    PrivacyPolicyResponse({
        this.success,
        this.data,
        this.message,
        this.code,
    });

    PrivacyPolicyResponse copyWith({
        bool? success,
        Data? data,
        String? message,
        int? code,
    }) => 
        PrivacyPolicyResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
            code: code ?? this.code,
        );

    factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) => PrivacyPolicyResponse(
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
    String? privacyPolicy;

    Data({
        this.privacyPolicy,
    });

    Data copyWith({
        String? privacyPolicy,
    }) => 
        Data(
            privacyPolicy: privacyPolicy ?? this.privacyPolicy,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        privacyPolicy: json["privacy_policy"],
    );

    Map<String, dynamic> toJson() => {
        "privacy_policy": privacyPolicy,
    };
}
