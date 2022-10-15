// To parse this JSON data, do
//
//     final succesfullWalletTransfer = succesfullWalletTransferFromJson(jsonString);

import 'dart:convert';

SuccesfullWalletTransfer succesfullWalletTransferFromJson(String str) => SuccesfullWalletTransfer.fromJson(json.decode(str));

String succesfullWalletTransferToJson(SuccesfullWalletTransfer data) => json.encode(data.toJson());

class SuccesfullWalletTransfer {
    SuccesfullWalletTransfer({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    SuccesfullWalletTransferData data;

    factory SuccesfullWalletTransfer.fromJson(Map<String, dynamic> json) => SuccesfullWalletTransfer(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: SuccesfullWalletTransferData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class SuccesfullWalletTransferData {
    SuccesfullWalletTransferData({
        required this.data,
        required this.amount,
        required this.fee,
        required this.channel,
        required this.reference,
        required this.type,
        required this.status,
        required this.createdAt,
    });

    DataData data;
    String amount;
    String fee;
    String channel;
    String reference;
    String type;
    String status;
    DateTime createdAt;

    factory SuccesfullWalletTransferData.fromJson(Map<String, dynamic> json) => SuccesfullWalletTransferData(
        data: DataData.fromJson(json["data"]),
        amount: json["amount"],
        fee: json["fee"],
        channel: json["channel"],
        reference: json["reference"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "amount": amount,
        "fee": fee,
        "channel": channel,
        "reference": reference,
        "type": type,
        "status": status,
        "created_at": createdAt.toIso8601String(),
    };
}

class DataData {
    DataData({
        required this.description,
        required this.from,
        required this.to,
    });

    String description;
    String from;
    String to;

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        description: json["description"],
        from: json["from"],
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "from": from,
        "to": to,
    };
}
