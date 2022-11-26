// To parse this JSON data, do
//
//     final deposit = depositFromJson(jsonString);

import 'dart:convert';

Deposit depositFromJson(String str) => Deposit.fromJson(json.decode(str));

String depositToJson(Deposit data) => json.encode(data.toJson());

class Deposit {
    Deposit({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
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
        required this.link,
    });

    String link;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "link": link,
    };
}
