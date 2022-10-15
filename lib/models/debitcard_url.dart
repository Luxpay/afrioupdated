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
        required this.fullName,
        required this.encryptionKey,
        required this.publicKey,
        required this.amount,
        required this.metaData,
        required this.email,
        required this.txRef,
        required this.phone,
    });

    String fullName;
    String encryptionKey;
    String publicKey;
    String amount;
    MetaData metaData;
    String email;
    String txRef;
    String phone;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        fullName: json["full_name"],
        encryptionKey: json["encryption_key"],
        publicKey: json["public_key"],
        amount: json["amount"],
        metaData: MetaData.fromJson(json["meta_data"]),
        email: json["email"],
        txRef: json["tx_ref"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "encryption_key": encryptionKey,
        "public_key": publicKey,
        "amount": amount,
        "meta_data": metaData.toJson(),
        "email": email,
        "tx_ref": txRef,
        "phone": phone,
    };
}

class MetaData {
    MetaData({
        required this.transactionId,
        required this.reference,
        required this.channel,
    });

    String transactionId;
    String reference;
    String channel;

    factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        transactionId: json["transaction_id"],
        reference: json["reference"],
        channel: json["channel"],
    );

    Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "reference": reference,
        "channel": channel,
    };
}
