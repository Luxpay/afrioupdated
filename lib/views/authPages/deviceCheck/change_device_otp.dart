// To parse this JSON data, do
//
//     final changeDevice = changeDeviceFromJson(jsonString);

import 'dart:convert';

ChangeDevice changeDeviceFromJson(String str) => ChangeDevice.fromJson(json.decode(str));

String changeDeviceToJson(ChangeDevice data) => json.encode(data.toJson());

class ChangeDevice {
    ChangeDevice({
        required this.status,
        required this.code,
        this.message,
        required this.data,
    });

    String status;
    int code;
    dynamic message;
    Data data;

    factory ChangeDevice.fromJson(Map<String, dynamic> json) => ChangeDevice(
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
        required this.avatar,
        required this.username,
        required this.phone,
        required this.firstName,
        required this.lastName,
    });

    String avatar;
    String username;
    String phone;
    String firstName;
    String lastName;

    factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        username: json["username"],
        phone: json["phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "username": username,
        "phone": phone,
        "first_name": firstName,
        "last_name": lastName,
    };
}
