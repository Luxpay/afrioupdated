// To parse this JSON data, do
//
//     final otpverify = otpverifyFromJson(jsonString);

import 'dart:convert';

Otpverify otpverifyFromJson(String str) => Otpverify.fromJson(json.decode(str));

String otpverifyToJson(Otpverify data) => json.encode(data.toJson());

class Otpverify {
    Otpverify({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory Otpverify.fromJson(Map<String, dynamic> json) => Otpverify(
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
        required this.user,
        required this.token,
    });

    User user;
    String token;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    User({
        this.avatar,
        required this.username,
        this.email,
        required this.phone,
        this.firstName,
        this.lastName,
    });

    dynamic avatar;
    String username;
    dynamic email;
    String phone;
    dynamic firstName;
    dynamic lastName;

    factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "username": username,
        "email": email,
        "phone": phone,
        "first_name": firstName,
        "last_name": lastName,
    };
}
