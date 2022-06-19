// To parse this JSON data, do
//
//     final myWallets = myWalletsFromJson(jsonString);

import 'dart:convert';

MyWallets myWalletsFromJson(String str) => MyWallets.fromJson(json.decode(str));

String myWalletsToJson(MyWallets data) => json.encode(data.toJson());

class MyWallets {
  MyWallets({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  List<Datum> data;

  factory MyWallets.fromJson(Map<String, dynamic> json) => MyWallets(
        status: json["status"],
        errors: Errors.fromJson(json["errors"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errors": errors.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.balance,
    required this.balanceCurrency,
    required this.isDefault,
  });

  String balance;
  String balanceCurrency;
  bool isDefault;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        balance: json["balance"],
        balanceCurrency: json["balance_currency"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "balance_currency": balanceCurrency,
        "is_default": isDefault,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
