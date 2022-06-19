// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
    required this.tokens,
  });

  User user;
  Tokens tokens;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
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
    this.avatar,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.phoneVerified,
    required this.email,
    required this.emailVerified,
    required this.hasPin,
    required this.isVerified,
    required this.username,
  });

  dynamic avatar;
  String firstName;
  String lastName;
  String phone;
  bool phoneVerified;
  dynamic email;
  bool emailVerified;
  bool hasPin;
  bool isVerified;
  String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        phoneVerified: json["phone_verified"],
        email: json["email"],
        emailVerified: json["email_verified"],
        hasPin: json["has_pin"],
        isVerified: json["is_verified"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "phone_verified": phoneVerified,
        "email": email,
        "email_verified": emailVerified,
        "has_pin": hasPin,
        "is_verified": isVerified,
        "username": username,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
