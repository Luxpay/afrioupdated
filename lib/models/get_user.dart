// To parse this JSON data, do
//
//     final resolveUserAccount = resolveUserAccountFromJson(jsonString);

import 'dart:convert';

ResolveUserAccount resolveUserAccountFromJson(String str) => ResolveUserAccount.fromJson(json.decode(str));

String resolveUserAccountToJson(ResolveUserAccount data) => json.encode(data.toJson());

class ResolveUserAccount {
    ResolveUserAccount({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory ResolveUserAccount.fromJson(Map<String, dynamic> json) => ResolveUserAccount(
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
        this.fullName,
        this.avatar,
    });

    String username;
    dynamic fullName;
    dynamic avatar;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        fullName: json["full_name"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "full_name": fullName,
        "avatar": avatar,
    };
}
