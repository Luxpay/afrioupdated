// To parse this JSON data, do
//
//     final withdrawalBeneficiary = withdrawalBeneficiaryFromJson(jsonString);

import 'dart:convert';

WithdrawalBeneficiary withdrawalBeneficiaryFromJson(String str) => WithdrawalBeneficiary.fromJson(json.decode(str));

String withdrawalBeneficiaryToJson(WithdrawalBeneficiary data) => json.encode(data.toJson());

class WithdrawalBeneficiary {
    WithdrawalBeneficiary({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    String status;
    int code;
    String message;
    Data data;

    factory WithdrawalBeneficiary.fromJson(Map<String, dynamic> json) => WithdrawalBeneficiary(
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
        required this.limit,
        required this.offset,
        required this.count,
        this.next,
        this.previous,
        required this.results,
    });

    int limit;
    int offset;
    int count;
    dynamic next;
    dynamic previous;
    List<Results> results;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Results>.from(json["results"].map((x) => Results.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Results {
    Results({
        required this.accountName,
        required this.accountNumber,
        required this.bankName,
        required this.bankCode,
    });

    String accountName;
    String accountNumber;
    String bankName;
    String bankCode;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
    );

    Map<String, dynamic> toJson() => {
        "account_name": accountName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "bank_code": bankCode,
    };
}
