// To parse this JSON data, do
//
//     final referralError = referralErrorFromJson(jsonString);

import 'dart:convert';

ReferralError referralErrorFromJson(String str) =>
    ReferralError.fromJson(json.decode(str));

String referralErrorToJson(ReferralError data) => json.encode(data.toJson());

class ReferralError {
  ReferralError({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory ReferralError.fromJson(Map<String, dynamic> json) => ReferralError(
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
    required this.error,
  });

  List<String> error;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        error: List<String>.from(json["error"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "error": List<dynamic>.from(error.map((x) => x)),
      };
}
