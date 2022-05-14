import 'dart:convert';

import 'package:luxpay/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String? full_name;
  final dynamic gender;
  final dynamic dob;
  final String? phone_number;
  final String? email;
  final bool? phone_number_verified;
  final bool? email_verified;
  final bool? is_pin_set;
  final bool? is_active;
  User({
    this.full_name,
    this.gender,
    this.dob,
    this.phone_number,
    this.email,
    this.phone_number_verified,
    this.email_verified,
    this.is_pin_set,
    this.is_active,
  });

  Map<String, dynamic> toMap() {
    return {
      'full_name': full_name,
      'gender': gender,
      'dob': dob,
      'phone_number': phone_number,
      'email': email,
      'phone_number_verified': phone_number_verified,
      'email_verified': email_verified,
      'is_pin_set': is_pin_set,
      'is_active': is_active,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      full_name: map['full_name'],
      gender: map['gender'] ?? null,
      dob: map['dob'] ?? null,
      phone_number: map['phone_number'],
      email: map['email'],
      phone_number_verified: map['phone_number_verified'],
      email_verified: map['email_verified'],
      is_pin_set: map['is_pin_set'],
      is_active: map['is_active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  static Future<User> getFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User.fromMap(jsonDecode(prefs.getString(userPref) ?? ""));
  }
}
