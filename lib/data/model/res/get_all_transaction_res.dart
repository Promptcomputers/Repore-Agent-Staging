// To parse this JSON data, do
//
//     final getAllTransactionRes = getAllTransactionResFromJson(jsonString);

import 'dart:convert';

GetAllTransactionRes getAllTransactionResFromJson(String str) =>
    GetAllTransactionRes.fromJson(json.decode(str));

String getAllTransactionResToJson(GetAllTransactionRes data) =>
    json.encode(data.toJson());

class GetAllTransactionRes {
  List<GellAllTransaction> data;

  GetAllTransactionRes({
    required this.data,
  });

  factory GetAllTransactionRes.fromJson(Map<String, dynamic> json) =>
      GetAllTransactionRes(
        data: List<GellAllTransaction>.from(
            json["data"].map((x) => GellAllTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GellAllTransaction {
  String id;
  String amount;
  String type;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GellAllTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GellAllTransaction.fromJson(Map<String, dynamic> json) =>
      GellAllTransaction(
        id: json["_id"] ?? '',
        amount: json["amount"] ?? '',
        type: json["type"] ?? '',
        user: json["user"] ?? '',
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "type": type,
        "user": user,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}
