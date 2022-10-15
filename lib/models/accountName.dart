// To parse this JSON data, do
//
//     final getAccountName = getAccountNameFromJson(jsonString);

import 'dart:convert';

GetAccountName getAccountNameFromJson(String str) =>
    GetAccountName.fromJson(json.decode(str));

String getAccountNameToJson(GetAccountName data) => json.encode(data.toJson());

class GetAccountName {
  GetAccountName({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  String status;
  int code;
  String message;
  Data data;

  factory GetAccountName.fromJson(Map<String, dynamic> json) => GetAccountName(
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
    required this.accountName,
  });

  String accountName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountName: json["account_name"],
      );

  Map<String, dynamic> toJson() => {
        "account_name": accountName,
      };
}
