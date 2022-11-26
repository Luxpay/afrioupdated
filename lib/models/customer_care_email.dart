// To parse this JSON data, do
//
//     final customerEmail = customerEmailFromJson(jsonString);

import 'dart:convert';

CustomerEmail customerEmailFromJson(String str) => CustomerEmail.fromJson(json.decode(str));

String customerEmailToJson(CustomerEmail data) => json.encode(data.toJson());

class CustomerEmail {
    CustomerEmail({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory CustomerEmail.fromJson(Map<String, dynamic> json) => CustomerEmail(
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
        required this.email,
    });

    String email;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
    };
}
