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
        required this.directReferred,
        required this.indirectReferred,
        required this.canWithdraw,
        required this.isActive,
        required this.totalEarnings,
        required this.todaysEarnings,
    });

    Package package;
    List<String> directReferred;
    List<String> indirectReferred;
    bool canWithdraw;
    bool isActive;
    String totalEarnings;
    String todaysEarnings;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        package: Package.fromJson(json["package"]),
        directReferred: List<String>.from(json["direct_referred"].map((x) => x)),
        indirectReferred: List<String>.from(json["indirect_referred"].map((x) => x)),
        canWithdraw: json["can_withdraw"],
        isActive: json["is_active"],
        totalEarnings: json["total_earnings"],
        todaysEarnings: json["todays_earnings"],
    );

    Map<String, dynamic> toJson() => {
        "package": package.toJson(),
        "direct_referred": List<dynamic>.from(directReferred.map((x) => x)),
        "indirect_referred": List<dynamic>.from(indirectReferred.map((x) => x)),
        "can_withdraw": canWithdraw,
        "is_active": isActive,
        "total_earnings": totalEarnings,
        "todays_earnings": todaysEarnings,
    };
}

class Package {
    Package({
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

    factory Package.fromJson(Map<String, dynamic> json) => Package(
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
