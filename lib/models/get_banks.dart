// To parse this JSON data, do
//
//     final getBanks = getBanksFromJson(jsonString);

import 'dart:convert';

GetBanks getBanksFromJson(String str) => GetBanks.fromJson(json.decode(str));

String getBanksToJson(GetBanks data) => json.encode(data.toJson());

class GetBanks {
    GetBanks({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    List<Datum> data;

    factory GetBanks.fromJson(Map<String, dynamic> json) => GetBanks(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.bankName,
        required this.bankCode,
    });

    String bankName;
    String bankCode;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
    );

    Map<String, dynamic> toJson() => {
        "bank_name": bankName,
        "bank_code": bankCode,
    };
}
