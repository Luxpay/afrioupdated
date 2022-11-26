// To parse this JSON data, do
//
//     final cycleCrow365 = cycleCrow365FromJson(jsonString);

import 'dart:convert';

CycleCrowd365 cycleCrow365FromJson(String str) => CycleCrowd365.fromJson(json.decode(str));

String cycleCrow365ToJson(CycleCrowd365 data) => json.encode(data.toJson());

class CycleCrowd365 {
    CycleCrowd365({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory CycleCrowd365.fromJson(Map<String, dynamic> json) => CycleCrowd365(
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
        required this.cycles,
    });

    int cycles;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cycles: json["cycles"],
    );

    Map<String, dynamic> toJson() => {
        "cycles": cycles,
    };
}
