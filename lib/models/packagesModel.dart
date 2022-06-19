// To parse this JSON data, do
//
//     final packages = packagesFromJson(jsonString);

import 'dart:convert';

Packages packagesFromJson(String str) => Packages.fromJson(json.decode(str));

String packagesToJson(Packages data) => json.encode(data.toJson());

class Packages {
  Packages({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
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
    required this.packages,
  });

  List<Package> packages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        packages: List<Package>.from(
            json["packages"].map((x) => Package.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
      };
}

class Package {
  Package({
    required this.name,
    required this.price,
    required this.priceCurrency,
  });

  String name;
  String price;
  String priceCurrency;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
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

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
