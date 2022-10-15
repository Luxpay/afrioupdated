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
  List<Datum> data;

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
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
    required this.name,
    required this.price,
    required this.welcomeBonus,
    required this.reward,
    required this.eachCycle,
  });

  String name;
  String price;
  String welcomeBonus;
  String reward;
  String eachCycle;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        price: json["price"],
        welcomeBonus: json["welcome_bonus"],
        reward: json["reward"],
        eachCycle: json["each_cycle"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "welcome_bonus": welcomeBonus,
        "reward": reward,
        "each_cycle": eachCycle,
      };
}
