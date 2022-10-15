// To parse this JSON data, do
//
//     final luxpayBeneficiary = luxpayBeneficiaryFromJson(jsonString);

import 'dart:convert';

LuxpayBene luxpayBeneficiaryFromJson(String str) => LuxpayBene.fromJson(json.decode(str));

String luxpayBeneficiaryToJson(LuxpayBene data) => json.encode(data.toJson());

class LuxpayBene {
    LuxpayBene({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory LuxpayBene.fromJson(Map<String, dynamic> json) => LuxpayBene(
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
        required this.avatar,
        required this.fullName,
        required this.username,
    });

    String avatar;
    String fullName;
    String username;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        avatar: json["avatar"],
        fullName: json["full_name"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "full_name": fullName,
        "username": username,
    };
}
