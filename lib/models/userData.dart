// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
       this.username,
         this.phone,
         this.firstName,
         this.lastName,
        this.gender,
         this.avatar,
         this.kycLevel,
       this.email,
        this.emailVerified,
    });

    String? username;
    String? phone;
    String? firstName;
    String? lastName;
    String? gender;
    String? avatar;
    int? kycLevel;
    String? email;
    bool? emailVerified;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        phone: json["phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
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
        "gender": gender,
        "avatar": avatar,
        "kyc_level": kycLevel,
        "email": email,
        "email_verified": emailVerified,
    };
}
