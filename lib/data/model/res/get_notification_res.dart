// To parse this JSON data, do
//
//     final getNotificationRes = getNotificationResFromJson(jsonString);

import 'dart:convert';

GetNotificationRes getNotificationResFromJson(String str) =>
    GetNotificationRes.fromJson(json.decode(str));

String getNotificationResToJson(GetNotificationRes data) =>
    json.encode(data.toJson());

class GetNotificationRes {
  final List<NoticationDatum> data;

  GetNotificationRes({
    required this.data,
  });

  factory GetNotificationRes.fromJson(Map<String, dynamic> json) =>
      GetNotificationRes(
        data: List<NoticationDatum>.from(
            json["data"].map((x) => NoticationDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NoticationDatum {
  final String id;
  final String title;
  final String user;
  final String description;
  final Metadata? metadata;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;

  NoticationDatum({
    required this.id,
    required this.title,
    required this.user,
    required this.description,
    required this.metadata,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NoticationDatum.fromJson(Map<String, dynamic> json) =>
      NoticationDatum(
        id: json["_id"] ?? "",
        title: json["title"] ?? "",
        user: json["user"] ?? '',
        description: json["description"] ?? '',
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        status: json["status"] ?? false,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "user": user,
        "description": description,
        "metadata": metadata!.toJson(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Metadata {
  final String id;
  final String ticket;
  final String subject;
  final String invoice;

  Metadata({
    required this.id,
    required this.ticket,
    required this.subject,
    required this.invoice,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        id: json["_id"] ?? '',
        ticket: json["ticket"] ?? '',
        subject: json["subject"] ?? '',
        invoice: json["invoice"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ticket": ticket,
        "subject": subject,
        "invoice": invoice,
      };
}
