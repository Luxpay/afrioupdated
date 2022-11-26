// To parse this JSON data, do
//
//     final kycDetails = kycDetailsFromJson(jsonString);

import 'dart:convert';

KycDetails kycDetailsFromJson(String str) =>
    KycDetails.fromJson(json.decode(str));

String kycDetailsToJson(KycDetails data) => json.encode(data.toJson());

class KycDetails {
  KycDetails({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  String status;
  int code;
  String message;
  Data data;

  factory KycDetails.fromJson(Map<String, dynamic> json) => KycDetails(
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
    required this.user,
    required this.phone,
    required this.idType,
    required this.idNumber,
  });

  User user;
  String phone;
  String idType;
  String idNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        phone: json["phone"],
        idType: json["id_type"],
        idNumber: json["id_number"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "phone": phone,
        "id_type": idType,
        "id_number": idNumber,
      };
}

class User {
  User({
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
  });

  String firstName;
  String? middleName;
  String lastName;
  String gender;
  DateTime dateOfBirth;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "gender": gender,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
      };
}
