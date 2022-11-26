// To parse this JSON data, do
//
//     final getAccountDetails = getAccountDetailsFromJson(jsonString);

import 'dart:convert';

GetAccountDetails getAccountDetailsFromJson(String str) => GetAccountDetails.fromJson(json.decode(str));

String getAccountDetailsToJson(GetAccountDetails data) => json.encode(data.toJson());

class GetAccountDetails {
    GetAccountDetails({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    List<Datum> data;

    factory GetAccountDetails.fromJson(Map<String, dynamic> json) => GetAccountDetails(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.accountName,
        required this.accountNumber,
        required this.bankName,
    });

    String accountName;
    String accountNumber;
    String bankName;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
    );

    Map<String, dynamic> toJson() => {
        "account_name": accountName,
        "account_number": accountNumber,
        "bank_name": bankName,
    };
}
