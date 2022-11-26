// To parse this JSON data, do
//
//     final allKycLevels = allKycLevelsFromJson(jsonString);

import 'dart:convert';

AllKycLevels allKycLevelsFromJson(String str) => AllKycLevels.fromJson(json.decode(str));

String allKycLevelsToJson(AllKycLevels data) => json.encode(data.toJson());

class AllKycLevels {
    AllKycLevels({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    List<Datum> data;

    factory AllKycLevels.fromJson(Map<String, dynamic> json) => AllKycLevels(
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
        required this.single,
        required this.cummulativeLimit,
        required this.balanceLimit,
        required this.dailyLimit,
    });

    Single single;
    String? cummulativeLimit;
    String? balanceLimit;
    String dailyLimit;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        single: Single.fromJson(json["single"]),
        cummulativeLimit: json["cummulative_limit"] == null ? null : json["cummulative_limit"],
        balanceLimit: json["balance_limit"] == null ? null : json["balance_limit"],
        dailyLimit: json["daily_limit"],
    );

    Map<String, dynamic> toJson() => {
        "single": single.toJson(),
        "cummulative_limit": cummulativeLimit == null ? null : cummulativeLimit,
        "balance_limit": balanceLimit == null ? null : balanceLimit,
        "daily_limit": dailyLimit,
    };
}

class Single {
    Single({
        required this.debit,
        required this.credit,
    });

    String debit;
    String? credit;

    factory Single.fromJson(Map<String, dynamic> json) => Single(
        debit: json["debit"],
        credit: json["credit"] == null ? null : json["credit"],
    );

    Map<String, dynamic> toJson() => {
        "debit": debit,
        "credit": credit == null ? null : credit,
    };
}
