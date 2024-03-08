// To parse this JSON data, do
//
//     final failureModelRes = failureModelResFromJson(jsonString);

import 'dart:convert';

FailureModelRes failureModelResFromJson(String str) =>
    FailureModelRes.fromJson(json.decode(str));

String failureModelResToJson(FailureModelRes data) =>
    json.encode(data.toJson());

class FailureModelRes {
  List<Error> errors;

  FailureModelRes({
    required this.errors,
  });

  factory FailureModelRes.fromJson(Map<String, dynamic> json) =>
      FailureModelRes(
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
      };
}

class Error {
  String message;

  Error({
    required this.message,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
