// To parse this JSON data, do
//
//     final verifyOtp = verifyOtpFromJson(jsonString);

import 'dart:convert';

VerifyOtp verifyOtpFromJson(String str) => VerifyOtp.fromJson(json.decode(str));

String verifyOtpToJson(VerifyOtp data) => json.encode(data.toJson());

class VerifyOtp {
    VerifyOtp({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.resetId,
        required this.code,
    });

    String resetId;
    String code;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        resetId: json["reset_id"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "reset_id": resetId,
        "code": code,
    };
}
