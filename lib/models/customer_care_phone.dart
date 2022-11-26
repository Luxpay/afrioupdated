// To parse this JSON data, do
//
//     final customerPhone = customerPhoneFromJson(jsonString);

import 'dart:convert';

CustomerPhone customerPhoneFromJson(String str) => CustomerPhone.fromJson(json.decode(str));

String customerPhoneToJson(CustomerPhone data) => json.encode(data.toJson());

class CustomerPhone {
    CustomerPhone({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory CustomerPhone.fromJson(Map<String, dynamic> json) => CustomerPhone(
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
        required this.phone,
    });

    String phone;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
    };
}
