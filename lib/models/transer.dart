// To parse this JSON data, do
//
//     final transferData = transferDataFromJson(jsonString);

import 'dart:convert';

TransferData transferDataFromJson(String str) => TransferData.fromJson(json.decode(str));

String transferDataToJson(TransferData data) => json.encode(data.toJson());

class TransferData {
    TransferData({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory TransferData.fromJson(Map<String, dynamic> json) => TransferData(
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
        required this.transaction,
        required this.type,
    });

    Transaction transaction;
    String type;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        transaction: Transaction.fromJson(json["transaction"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "transaction": transaction.toJson(),
        "type": type,
    };
}

class Transaction {
    Transaction({
        required this.amount,
        required this.channel,
        required this.status,
        required this.reference,
    });

    String amount;
    String channel;
    String status;
    String reference;

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"],
        channel: json["channel"],
        status: json["status"],
        reference: json["reference"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "channel": channel,
        "status": status,
        "reference": reference,
    };
}
