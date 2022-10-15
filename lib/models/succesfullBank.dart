// To parse this JSON data, do
//
//     final transactionDetails = transactionDetailsFromJson(jsonString);

import 'dart:convert';

SuccessfullBankTransaction transactionDetailsFromJson(String str) => SuccessfullBankTransaction.fromJson(json.decode(str));

String transactionDetailsToJson(SuccessfullBankTransaction data) => json.encode(data.toJson());

class SuccessfullBankTransaction {
    SuccessfullBankTransaction({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    TransactionDetailsData data;

    factory SuccessfullBankTransaction.fromJson(Map<String, dynamic> json) => SuccessfullBankTransaction(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: TransactionDetailsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class TransactionDetailsData {
    TransactionDetailsData({
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

    factory TransactionDetailsData.fromJson(Map<String, dynamic> json) => TransactionDetailsData(
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
        required this.accountNumber,
        required this.bankName,
    });

    String description;
    String from;
    String to;
    String accountNumber;
    String bankName;

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        description: json["description"],
        from: json["from"],
        to: json["to"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "from": from,
        "to": to,
        "account_number": accountNumber,
        "bank_name": bankName,
    };
}
