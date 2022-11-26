// To parse this JSON data, do
//
//     final kycList = kycListFromJson(jsonString);

import 'dart:convert';

KycHistory kycListFromJson(String str) => KycHistory.fromJson(json.decode(str));

String kycListToJson(KycHistory data) => json.encode(data.toJson());

class KycHistory {
  KycHistory({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  String status;
  int code;
  String message;
  Data data;

  factory KycHistory.fromJson(Map<String, dynamic> json) => KycHistory(
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
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
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
    required this.id,
    required this.phone,
    required this.status,
    required this.createdAt,
  });

  String id;
  String phone;
  String status;
  DateTime createdAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        phone: json["phone"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
