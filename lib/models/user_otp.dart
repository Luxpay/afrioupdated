// To parse this JSON data, do
//
//     final userOtp = userOtpFromJson(jsonString);

import 'dart:convert';

UserOtp userOtpFromJson(String str) => UserOtp.fromJson(json.decode(str));

String userOtpToJson(UserOtp data) => json.encode(data.toJson());

class UserOtp {
  UserOtp({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory UserOtp.fromJson(Map<String, dynamic> json) => UserOtp(
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
    required this.otp,
  });

  String otp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
