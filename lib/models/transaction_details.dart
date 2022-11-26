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
    required this.id,
    required this.amount,
    required this.type,
    required this.status,
    required this.reference,
    required this.data,
    required this.channel,
    required this.fee,
    required this.createdAt,
    required this.actualAmount,
  });

  String id;
  String amount;
  String type;
  String status;
  String reference;
  DataData data;
  String channel;
  String fee;
  DateTime createdAt;
  String actualAmount;

  factory TransactionDetailsData.fromJson(Map<String, dynamic> json) =>
      TransactionDetailsData(
        id: json["id"],
        amount: json["amount"],
        type: json["type"],
        status: json["status"],
        reference: json["reference"],
        data: DataData.fromJson(json["data"]),
        channel: json["channel"],
        fee: json["fee"],
        createdAt: DateTime.parse(json["created_at"]),
        actualAmount: json["actual_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "type": type,
        "status": status,
        "reference": reference,
        "data": data.toJson(),
        "channel": channel,
        "fee": fee,
        "created_at": createdAt.toIso8601String(),
        "actual_amount": actualAmount,
      };
}

class DataData {
  DataData({
    required this.to,
    required this.from,
    this.description,
  });

  String to;
  String from;
  String? description;

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
