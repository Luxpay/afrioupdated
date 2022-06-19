// To parse this JSON data, do
//
//     final expiredToken = expiredTokenFromJson(jsonString);

import 'dart:convert';

ExpiredToken expiredTokenFromJson(String str) =>
    ExpiredToken.fromJson(json.decode(str));

String expiredTokenToJson(ExpiredToken data) => json.encode(data.toJson());

class ExpiredToken {
  ExpiredToken({
    required this.status,
    required this.errors,
    required this.data,
  });

  bool status;
  Errors errors;
  Data data;

  factory ExpiredToken.fromJson(Map<String, dynamic> json) => ExpiredToken(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}

class Errors {
  Errors({
    required this.message,
    required this.extra,
  });

  ErrorsMessage message;
  Data extra;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        message: ErrorsMessage.fromJson(json["message"]),
        extra: Data.fromJson(json["extra"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "extra": extra.toJson(),
      };
}

class ErrorsMessage {
  ErrorsMessage({
    required this.detail,
    required this.code,
    required this.messages,
  });

  String detail;
  String code;
  List<MessageElement> messages;

  factory ErrorsMessage.fromJson(Map<String, dynamic> json) => ErrorsMessage(
        detail: json["detail"],
        code: json["code"],
        messages: List<MessageElement>.from(
            json["messages"].map((x) => MessageElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
        "code": code,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class MessageElement {
  MessageElement({
    required this.tokenClass,
    required this.tokenType,
    required this.message,
  });

  String tokenClass;
  String tokenType;
  String message;

  factory MessageElement.fromJson(Map<String, dynamic> json) => MessageElement(
        tokenClass: json["token_class"],
        tokenType: json["token_type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "token_class": tokenClass,
        "token_type": tokenType,
        "message": message,
      };
}
