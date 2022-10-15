// To parse this JSON data, do
//
//     final aboutUser = aboutUserFromJson(jsonString);

import 'dart:convert';

AboutUser aboutUserFromJson(String str) => AboutUser.fromJson(json.decode(str));

String aboutUserToJson(AboutUser data) => json.encode(data.toJson());

class AboutUser {
    AboutUser({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory AboutUser.fromJson(Map<String, dynamic> json) => AboutUser(
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
        required this.username,
        required this.phone,
        required this.firstName,
        required this.lastName,
        required this.avatar,
        required this.kycLevel,
        required this.email,
        required this.emailVerified,
    });

    String username;
    String phone;
    String firstName;
    String lastName;
    String avatar;
    int kycLevel;
    String email;
    bool emailVerified;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        phone: json["phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
        kycLevel: json["kyc_level"],
        email: json["email"],
        emailVerified: json["email_verified"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "phone": phone,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
        "kyc_level": kycLevel,
        "email": email,
        "email_verified": emailVerified,
    };
}
