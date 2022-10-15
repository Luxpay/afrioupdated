// To parse this JSON data, do
//
//     final userOtp = userOtpFromJson(jsonString);

import 'dart:convert';

UserOtp userOtpFromJson(String str) => UserOtp.fromJson(json.decode(str));

String userOtpToJson(UserOtp data) => json.encode(data.toJson());

class UserOtp {
    UserOtp({
        required this.status,
        required this.code,
        required this.data,
        this.message,
    });

    String status;
    int code;
    Data data;
    dynamic message;

    factory UserOtp.fromJson(Map<String, dynamic> json) => UserOtp(
        status: json["status"],
        code: json["code"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        required this.code,
    });

    String code;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
    };
}
