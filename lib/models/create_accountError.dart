// To parse this JSON data, do
//
//     final errorMessages = errorMessagesFromJson(jsonString);

import 'dart:convert';

ErrorCreateAccount errorMessagesFromJson(String str) =>
    ErrorCreateAccount.fromJson(json.decode(str));

String errorMessagesToJson(ErrorCreateAccount data) => json.encode(data.toJson());

class ErrorCreateAccount {
  ErrorCreateAccount({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory ErrorCreateAccount.fromJson(Map<String, dynamic> json) => ErrorCreateAccount(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}

class Errors {
  Errors({
    required this.message,
    required this.extra,
  });

  String message;
  Extra extra;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        message: json["message"],
        extra: Extra.fromJson(json["extra"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "extra": extra.toJson(),
      };
}

class Extra {
  Extra({
    required this.password,
  });

  List<String> password;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        password: List<String>.from(json["password"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "password": List<dynamic>.from(password.map((x) => x)),
      };
}
