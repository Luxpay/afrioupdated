// To parse this JSON data, do
//
//     final errorMessages = errorMessagesFromJson(jsonString);

import 'dart:convert';

LoginData errorMessagesFromJson(String str) =>
    LoginData.fromJson(json.decode(str));

String errorMessagesToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
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
    required this.user,
    required this.next,
    required this.tokens,
  });

  User user;
  dynamic next;
  Tokens tokens;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        next: json["next"],
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "next": next,
        "tokens": tokens.toJson(),
      };
}

class Tokens {
  Tokens({
    required this.access,
    required this.refresh,
  });

  String access;
  String refresh;

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: json["access"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
      };
}

class User {
  User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.createdAt,
  });

  String username;
  String firstName;
  String lastName;
  String phone;
  String email;
  DateTime createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "created_at": createdAt.toIso8601String(),
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
