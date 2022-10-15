// To parse this JSON data, do
//
//     final transactionHistory = transactionHistoryFromJson(jsonString);

import 'dart:convert';

TransactionHistory transactionHistoryFromJson(String str) => TransactionHistory.fromJson(json.decode(str));

String transactionHistoryToJson(TransactionHistory data) => json.encode(data.toJson());

class TransactionHistory {
    TransactionHistory({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
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
        required this.limit,
        required this.offset,
        required this.count,
        this.next,
        this.previous,
        required this.results,
    });

    int limit;
    int offset;
    int count;
    dynamic next;
    dynamic previous;
    List<Result> results;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.amount,
        required this.reference,
        required this.type,
        required this.status,
        required this.createdAt,
    });

    String amount;
    String reference;
    String type;
    String status;
    DateTime createdAt;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        amount: json["amount"],
        reference: json["reference"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "reference": reference,
        "type": type,
        "status": status,
        "created_at": createdAt.toIso8601String(),
    };
}
