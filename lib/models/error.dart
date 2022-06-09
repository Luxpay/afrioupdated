// To parse this JSON data, do
//
//     final errorMessages = errorMessagesFromJson(jsonString);

import 'dart:convert';

ErrorMessages errorMessagesFromJson(String str) =>
    ErrorMessages.fromJson(json.decode(str));

String errorMessagesToJson(ErrorMessages data) => json.encode(data.toJson());

class ErrorMessages {
  ErrorMessages({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory ErrorMessages.fromJson(Map<String, dynamic> json) => ErrorMessages(
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
  Data extra;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        message: json["message"],
        extra: Data.fromJson(json["extra"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "extra": extra.toJson(),
      };
}
