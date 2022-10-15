// To parse this JSON data, do
//
//     final aboutWallet = aboutWalletFromJson(jsonString);

import 'dart:convert';

AboutWallet aboutWalletFromJson(String str) => AboutWallet.fromJson(json.decode(str));

String aboutWalletToJson(AboutWallet data) => json.encode(data.toJson());

class AboutWallet {
    AboutWallet({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory AboutWallet.fromJson(Map<String, dynamic> json) => AboutWallet(
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
        required this.balance,
        required this.hasPin,
        required this.isLocked,
        required this.dailySummary,
        required this.limits,
    });

    String balance;
    bool hasPin;
    bool isLocked;
    DailySummary dailySummary;
    Limits limits;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        balance: json["balance"],
        hasPin: json["has_pin"],
        isLocked: json["is_locked"],
        dailySummary: DailySummary.fromJson(json["daily_summary"]),
        limits: Limits.fromJson(json["limits"]),
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
        "has_pin": hasPin,
        "is_locked": isLocked,
        "daily_summary": dailySummary.toJson(),
        "limits": limits.toJson(),
    };
}

class DailySummary {
    DailySummary({
        required this.income,
        required this.expense,
    });

    String income;
    String expense;

    factory DailySummary.fromJson(Map<String, dynamic> json) => DailySummary(
        income: json["income"],
        expense: json["expense"],
    );

    Map<String, dynamic> toJson() => {
        "income": income,
        "expense": expense,
    };
}

class Limits {
    Limits({
        required this.singleLimit,
        required this.dailyLimits,
    });

    String singleLimit;
    DailyLimits dailyLimits;

    factory Limits.fromJson(Map<String, dynamic> json) => Limits(
        singleLimit: json["single_limit"],
        dailyLimits: DailyLimits.fromJson(json["daily_limits"]),
    );

    Map<String, dynamic> toJson() => {
        "single_limit": singleLimit,
        "daily_limits": dailyLimits.toJson(),
    };
}

class DailyLimits {
    DailyLimits({
        required this.cummulativeLimit,
        required this.limitRemaining,
    });

    String cummulativeLimit;
    String limitRemaining;

    factory DailyLimits.fromJson(Map<String, dynamic> json) => DailyLimits(
        cummulativeLimit: json["cummulative_limit"],
        limitRemaining: json["limit_remaining"],
    );

    Map<String, dynamic> toJson() => {
        "cummulative_limit": cummulativeLimit,
        "limit_remaining": limitRemaining,
    };
}
