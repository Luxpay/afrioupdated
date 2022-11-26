// To parse this JSON data, do
//
//     final signUpError = signUpErrorFromJson(jsonString);

import 'dart:convert';

SignUpError signUpErrorFromJson(String str) =>
    SignUpError.fromJson(json.decode(str));

String signUpErrorToJson(SignUpError data) => json.encode(data.toJson());

class SignUpError {
  SignUpError({
    required this.status,
    required this.code,
    this.message,
    required this.data,
  });

  String status;
  int code;
  dynamic message;
  Data data;

  factory SignUpError.fromJson(Map<String, dynamic> json) => SignUpError(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.phone,
    this.email,
    this.username,
    this.password,
  });

  List<String>? phone;
  List<String>? email;
  List<String>? username;
  List<String>? password;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: List<String>.from(json["phone"].map((x) => x)),
        email: List<String>.from(json["email"].map((x) => x)),
        username: List<String>.from(json["username"].map((x) => x)),
        password: List<String>.from(json["password"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "phone": List<dynamic>.from(phone!.map((x) => x)),
        "email": List<dynamic>.from(email!.map((x) => x)),
        "username": List<dynamic>.from(username!.map((x) => x)),
        "password": List<dynamic>.from(password!.map((x) => x)),
      };
}
