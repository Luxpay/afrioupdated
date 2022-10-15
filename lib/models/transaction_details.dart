// To parse this JSON data, do
//
//     final transactionDetails = transactionDetailsFromJson(jsonString);

import 'dart:convert';

TransactionDetails transactionDetailsFromJson(String str) =>
    TransactionDetails.fromJson(json.decode(str));

String transactionDetailsToJson(TransactionDetails data) =>
    json.encode(data.toJson());

class TransactionDetails {
  TransactionDetails({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  String status;
  int code;
  String message;
  TransactionDetailsData data;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      TransactionDetails(
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

  factory TransactionDetailsData.fromJson(Map<String, dynamic> json) =>
      TransactionDetailsData(
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
    required this.to,
    required this.from,
    required this.description,
  });

  String to;
  String from;
  String description;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        to: json["to"],
        from: json["from"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "from": from,
        "description": description,
      };
}
