// To parse this JSON data, do
//
//     final transferBeneficiary = transferBeneficiaryFromJson(jsonString);

import 'dart:convert';

TransferBeneficiary transferBeneficiaryFromJson(String str) => TransferBeneficiary.fromJson(json.decode(str));

String transferBeneficiaryToJson(TransferBeneficiary data) => json.encode(data.toJson());

class TransferBeneficiary {
    TransferBeneficiary({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    List<Datum> data;

    factory TransferBeneficiary.fromJson(Map<String, dynamic> json) => TransferBeneficiary(
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
        this.avatar,
        required this.fullName,
        required this.username,
    });

    dynamic avatar;
    String fullName;
    String username;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        avatar: json["avatar"],
        fullName: json["full_name"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "full_name": fullName,
        "username": username,
    };
}
