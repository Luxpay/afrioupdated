// To parse this JSON data, do
//
//     final aboutUser = aboutUserFromJson(jsonString);

import 'dart:convert';

AboutUser aboutUserFromJson(String str) => AboutUser.fromJson(json.decode(str));

String aboutUserToJson(AboutUser data) => json.encode(data.toJson());

class AboutUser {
  AboutUser({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory AboutUser.fromJson(Map<String, dynamic> json) => AboutUser(
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
   required this.avatar,
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

  String avatar;
  String firstName;
  String lastName;
  String phone;
  bool phoneVerified;
  dynamic email;
  bool emailVerified;
  bool hasPin;
  dynamic isVerified;
  String username;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
