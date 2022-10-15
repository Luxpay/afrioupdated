// To parse this JSON data, do
//
//     final cashOut = cashOutFromJson(jsonString);

import 'dart:convert';

CashOut cashOutFromJson(String str) => CashOut.fromJson(json.decode(str));

String cashOutToJson(CashOut data) => json.encode(data.toJson());

class CashOut {
    CashOut({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory CashOut.fromJson(Map<String, dynamic> json) => CashOut(
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
        required this.amount,
        required this.channel,
        required this.reference,
        required this.status,
        required this.type,
        required this.createdAt,
    });

    String amount;
    String channel;
    String reference;
    String status;
    String type;
    DateTime createdAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        amount: json["amount"],
        channel: json["channel"],
        reference: json["reference"],
        status: json["status"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "channel": channel,
        "reference": reference,
        "status": status,
        "type": type,
        "created_at": createdAt.toIso8601String(),
    };
}
