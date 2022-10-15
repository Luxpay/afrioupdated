// To parse this JSON data, do
//
//     final signup = signupFromJson(jsonString);

import 'dart:convert';

Signup signupFromJson(String str) => Signup.fromJson(json.decode(str));

String signupToJson(Signup data) => json.encode(data.toJson());

class Signup {
    Signup({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory Signup.fromJson(Map<String, dynamic> json) => Signup(
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
        this.avatar,
        required this.username,
        required this.phone,
        required this.firstName,
        required this.lastName,
        required this.createdAt,
    });

    dynamic avatar;
    String username;
    String phone;
    String firstName;
    String lastName;
    DateTime createdAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        avatar: json["avatar"],
        username: json["username"],
        phone: json["phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "username": username,
        "phone": phone,
        "first_name": firstName,
        "last_name": lastName,
        "created_at": createdAt.toIso8601String(),
    };
}
