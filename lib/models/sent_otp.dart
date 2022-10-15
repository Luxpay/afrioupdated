// To parse this JSON data, do
//
//     final senOtpResponse = senOtpResponseFromJson(jsonString);

import 'dart:convert';

SenOtpResponse senOtpResponseFromJson(String str) => SenOtpResponse.fromJson(json.decode(str));

String senOtpResponseToJson(SenOtpResponse data) => json.encode(data.toJson());

class SenOtpResponse {
    SenOtpResponse({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory SenOtpResponse.fromJson(Map<String, dynamic> json) => SenOtpResponse(
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
        required this.eventId,
        required this.createdAt,
        required this.expiresAt,
    });

    String eventId;
    DateTime createdAt;
    DateTime expiresAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        eventId: json["event_id"],
        createdAt: DateTime.parse(json["created_at"]),
        expiresAt: DateTime.parse(json["expires_at"]),
    );

    Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "created_at": createdAt.toIso8601String(),
        "expires_at": expiresAt.toIso8601String(),
    };
}
