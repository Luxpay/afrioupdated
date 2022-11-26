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
    List<Datum> data;

    factory ReferEarnDs.fromJson(Map<String, dynamic> json) => ReferEarnDs(
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
        required this.totalEarnings,
        required this.weeklyEarnings,
        required this.referEarn,
        required this.feature,
    });

    String totalEarnings;
    String weeklyEarnings;
    Feature referEarn;
    Feature feature;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        totalEarnings: json["total_earnings"],
        weeklyEarnings: json["weekly_earnings"],
        referEarn: Feature.fromJson(json["refer_earn"]),
        feature: Feature.fromJson(json["feature"]),
    );

    Map<String, dynamic> toJson() => {
        "total_earnings": totalEarnings,
        "weekly_earnings": weeklyEarnings,
        "refer_earn": referEarn.toJson(),
        "feature": feature.toJson(),
    };
}

class Feature {
    Feature({
        required this.totalReferrals,
        required this.totalEarnings,
        required this.weeklyReferrals,
        required this.weeklyEarnings,
    });

    int totalReferrals;
    String totalEarnings;
    int weeklyReferrals;
    String weeklyEarnings;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        totalReferrals: json["total_referrals"],
        totalEarnings: json["total_earnings"],
        weeklyReferrals: json["weekly_referrals"],
        weeklyEarnings: json["weekly_earnings"],
    );

    Map<String, dynamic> toJson() => {
        "total_referrals": totalReferrals,
        "total_earnings": totalEarnings,
        "weekly_referrals": weeklyReferrals,
        "weekly_earnings": weeklyEarnings,
    };
}
