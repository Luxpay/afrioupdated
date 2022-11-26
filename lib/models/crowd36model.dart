// To parse this JSON data, do
//
//     final crowd365Db = crowd365DbFromJson(jsonString);

import 'dart:convert';

Crowd365Db crowd365DbFromJson(String str) => Crowd365Db.fromJson(json.decode(str));

String crowd365DbToJson(Crowd365Db data) => json.encode(data.toJson());

class Crowd365Db {
    Crowd365Db({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    List<Datum> data;

    factory Crowd365Db.fromJson(Map<String, dynamic> json) => Crowd365Db(
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
        required this.package,
        required this.earnings,
        required this.history,
        required this.isActive,
        required this.canWithdraw,
        this.cycles,
    });

    Package package;
    Earnings earnings;
    List<History> history;
    bool isActive;
    bool canWithdraw;
    int? cycles;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        package: Package.fromJson(json["package"]),
        earnings: Earnings.fromJson(json["earnings"]),
        history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
        isActive: json["is_active"],
        canWithdraw: json["can_withdraw"],
        cycles: json["cycles"],
    );

    Map<String, dynamic> toJson() => {
        "package": package.toJson(),
        "earnings": earnings.toJson(),
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
        "is_active": isActive,
        "can_withdraw": canWithdraw,
        "cycles": cycles,
    };
}

class Earnings {
    Earnings({
        required this.total,
        required this.today,
    });

    String total;
    String today;

    factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
        total: json["total"],
        today: json["today"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "today": today,
    };
}

class History {
    History({
        required this.username,
        required this.referrals,
    });

    String username;
    List<Referral> referrals;

    factory History.fromJson(Map<String, dynamic> json) => History(
        username: json["username"],
        referrals: List<Referral>.from(json["referrals"].map((x) => Referral.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "referrals": List<dynamic>.from(referrals.map((x) => x.toJson())),
    };
}

class Referral {
    Referral({
        required this.username,
    });

    String username;

    factory Referral.fromJson(Map<String, dynamic> json) => Referral(
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
    };
}

class Package {
    Package({
        required this.name,
        required this.price,
        required this.rewards,
    });

    String name;
    String price;
    Rewards rewards;

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        name: json["name"],
        price: json["price"],
        rewards: Rewards.fromJson(json["rewards"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "rewards": rewards.toJson(),
    };
}

class Rewards {
    Rewards({
        required this.welcomeBonus,
        required this.perReferralEarning,
        required this.maxReferralEarning,
        required this.totalEarnings,
    });

    String welcomeBonus;
    String perReferralEarning;
    String maxReferralEarning;
    String totalEarnings;

    factory Rewards.fromJson(Map<String, dynamic> json) => Rewards(
        welcomeBonus: json["welcome_bonus"],
        perReferralEarning: json["per_referral_earning"],
        maxReferralEarning: json["max_referral_earning"],
        totalEarnings: json["total_earnings"],
    );

    Map<String, dynamic> toJson() => {
        "welcome_bonus": welcomeBonus,
        "per_referral_earning": perReferralEarning,
        "max_referral_earning": maxReferralEarning,
        "total_earnings": totalEarnings,
    };
}
