// To parse this JSON data, do
//
//     final getBankDetailRes = getBankDetailResFromJson(jsonString);

import 'dart:convert';

GetBankDetailRes getBankDetailResFromJson(String str) =>
    GetBankDetailRes.fromJson(json.decode(str));

String getBankDetailResToJson(GetBankDetailRes data) =>
    json.encode(data.toJson());

class GetBankDetailRes {
  List<GetBankDetailDatum> data;

  GetBankDetailRes({
    required this.data,
  });

  factory GetBankDetailRes.fromJson(Map<String, dynamic> json) =>
      GetBankDetailRes(
        data: List<GetBankDetailDatum>.from(
            json["data"].map((x) => GetBankDetailDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetBankDetailDatum {
  String id;
  String stripeCustomerId;
  String bankAccount;
  String bankName;
  String routingNo;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GetBankDetailDatum({
    required this.id,
    required this.stripeCustomerId,
    required this.bankAccount,
    required this.bankName,
    required this.routingNo,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetBankDetailDatum.fromJson(Map<String, dynamic> json) =>
      GetBankDetailDatum(
        id: json["_id"] ?? '',
        stripeCustomerId: json["stripe_customer_id"] ?? '',
        bankAccount: json["bank_account"] ?? "",
        bankName: json["bank_name"] ?? '',
        routingNo: json["routing_no"] ?? '',
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
        "stripe_customer_id": stripeCustomerId,
        "bank_account": bankAccount,
        "routing_no": routingNo,
        "bank_name": bankName,
        "user": user,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}
