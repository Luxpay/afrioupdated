// To parse this JSON data, do
//
//     final crowd365Db = crowd365DbFromJson(jsonString);

import 'dart:convert';

Crowd365Db crowd365DbFromJson(String str) =>
    Crowd365Db.fromJson(json.decode(str));

String crowd365DbToJson(Crowd365Db data) => json.encode(data.toJson());

class Crowd365Db {
  Crowd365Db({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory Crowd365Db.fromJson(Map<String, dynamic> json) => Crowd365Db(
        status: json["status"],
        errors: Errors.fromJson(json["errors"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errors": errors.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.canWithdraw,
    required this.earnings,
    required this.referrals,
    required this.cycles,
    required this.payout,
    required this.referralCode,
    required this.plan,
  });

  bool canWithdraw;
  Earnings earnings;
  Referrals referrals;
  int cycles;
  String payout;
  String referralCode;
  Plan plan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        canWithdraw: json["can_withdraw"],
        earnings: Earnings.fromJson(json["earnings"]),
        referrals: Referrals.fromJson(json["referrals"]),
        cycles: json["cycles"],
        payout: json["payout"],
        referralCode: json["referral_code"],
        plan: Plan.fromJson(json["plan"]),
      );

  Map<String, dynamic> toJson() => {
        "can_withdraw": canWithdraw,
        "earnings": earnings.toJson(),
        "referrals": referrals.toJson(),
        "cycles": cycles,
        "payout": payout,
        "referral_code": referralCode,
        "plan": plan.toJson(),
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

class Plan {
  Plan({
    required this.name,
    required this.price,
    required this.priceCurrency,
  });

  String name;
  String price;
  String priceCurrency;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        name: json["name"],
        price: json["price"],
        priceCurrency: json["price_currency"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "price_currency": priceCurrency,
      };
}

class Referrals {
  Referrals({
    required this.direct,
    required this.indirect,
  });

  int direct;
  int indirect;

  factory Referrals.fromJson(Map<String, dynamic> json) => Referrals(
        direct: json["direct"],
        indirect: json["indirect"],
      );

  Map<String, dynamic> toJson() => {
        "direct": direct,
        "indirect": indirect,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
