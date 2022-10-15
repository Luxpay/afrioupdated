// To parse this JSON data, do
//
//     final authError = authErrorFromJson(jsonString);

import 'dart:convert';

AuthError authErrorFromJson(String str) => AuthError.fromJson(json.decode(str));

String authErrorToJson(AuthError data) => json.encode(data.toJson());

class AuthError {
    AuthError({
        required this.status,
        required this.code,
        this.data,
        required this.message,
    });

    String status;
    int code;
    dynamic data;
    String message;

    factory AuthError.fromJson(Map<String, dynamic> json) => AuthError(
        status: json["status"],
        code: json["code"],
        data: json["data"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data,
        "message": message,
    };
}
