// To parse this JSON data, do
//
//     final resetOtp = resetOtpFromJson(jsonString);

import 'dart:convert';

ResetOtp resetOtpFromJson(String str) => ResetOtp.fromJson(json.decode(str));

String resetOtpToJson(ResetOtp data) => json.encode(data.toJson());

class ResetOtp {
    ResetOtp({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory ResetOtp.fromJson(Map<String, dynamic> json) => ResetOtp(
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
    });

    String resetId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        resetId: json["reset_id"],
    );

    Map<String, dynamic> toJson() => {
        "reset_id": resetId,
    };
}
