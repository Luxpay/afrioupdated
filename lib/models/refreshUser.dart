// To parse this JSON data, do
//
//     final refreahUser = refreahUserFromJson(jsonString);

import 'dart:convert';

RefreahUser refreahUserFromJson(String str) =>
    RefreahUser.fromJson(json.decode(str));

String refreahUserToJson(RefreahUser data) => json.encode(data.toJson());

class RefreahUser {
  RefreahUser({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory RefreahUser.fromJson(Map<String, dynamic> json) => RefreahUser(
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
    required this.access,
    required this.refresh,
  });

  String access;
  String refresh;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        access: json["access"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
