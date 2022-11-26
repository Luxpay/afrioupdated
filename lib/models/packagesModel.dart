// To parse this JSON data, do
//
//     final packages = packagesFromJson(jsonString);

import 'dart:convert';

Packages packagesFromJson(String str) => Packages.fromJson(json.decode(str));

String packagesToJson(Packages data) => json.encode(data.toJson());

class Packages {
  Packages({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  String status;
  int code;
  String message;
  List<Packs> data;

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<Packs>.from(json["data"].map((x) => Packs.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Packs {
  Packs({
    required this.name,
    required this.price,
    required this.rewards,
  });

  String name;
  String price;
  Rewards rewards;

  factory Packs.fromJson(Map<String, dynamic> json) => Packs(
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
