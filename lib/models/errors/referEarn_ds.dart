// To parse this JSON data, do
//
//     final referEarnDs = referEarnDsFromJson(jsonString);

import 'dart:convert';

ReferEarnDs referEarnDsFromJson(String str) => ReferEarnDs.fromJson(json.decode(str));

String referEarnDsToJson(ReferEarnDs data) => json.encode(data.toJson());

class ReferEarnDs {
    ReferEarnDs({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory ReferEarnDs.fromJson(Map<String, dynamic> json) => ReferEarnDs(
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
        required this.totalEarnings,
        required this.weeklyEarnings,
        required this.weeklyReferrals,
        required this.totalReferrals,
        required this.crowd365Referrals,
    });

    String totalEarnings;
    String weeklyEarnings;
    int weeklyReferrals;
    int totalReferrals;
    int crowd365Referrals;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalEarnings: json["total_earnings"],
        weeklyEarnings: json["weekly_earnings"],
        weeklyReferrals: json["weekly_referrals"],
        totalReferrals: json["total_referrals"],
        crowd365Referrals: json["crowd365_referrals"],
    );

    Map<String, dynamic> toJson() => {
        "total_earnings": totalEarnings,
        "weekly_earnings": weeklyEarnings,
        "weekly_referrals": weeklyReferrals,
        "total_referrals": totalReferrals,
        "crowd365_referrals": crowd365Referrals,
    };
}
