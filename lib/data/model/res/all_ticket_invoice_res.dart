// To parse this JSON data, do
//
//     final allTicketInvoiceRes = allTicketInvoiceResFromJson(jsonString);

import 'dart:convert';

AllTicketInvoiceRes allTicketInvoiceResFromJson(String str) =>
    AllTicketInvoiceRes.fromJson(json.decode(str));

String allTicketInvoiceResToJson(AllTicketInvoiceRes data) =>
    json.encode(data.toJson());

class AllTicketInvoiceRes {
  final List<TicketInvoiceDatum> data;

  AllTicketInvoiceRes({
    required this.data,
  });

  factory AllTicketInvoiceRes.fromJson(Map<String, dynamic> json) =>
      AllTicketInvoiceRes(
        data: List<TicketInvoiceDatum>.from(
            json["data"].map((x) => TicketInvoiceDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TicketInvoiceDatum {
  final String id;
  final String title;
  final String ticket;
  final String author;
  final String invoiceReference;
  final String approvalStatus;
  final num total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;
  final String invoiceType;
  final bool hasCashout;

  TicketInvoiceDatum({
    required this.id,
    required this.title,
    required this.ticket,
    required this.author,
    required this.invoiceReference,
    required this.approvalStatus,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.hasCashout,
    required this.invoiceType,
  });

  factory TicketInvoiceDatum.fromJson(Map<String, dynamic> json) =>
      TicketInvoiceDatum(
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        ticket: json["ticket"] ?? '',
        author: json["author"] ?? '',
        invoiceReference: json["invoice_reference"] ?? '',
        approvalStatus: json["approval_status"] ?? '',
        total: json["total"] ?? 0,
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
        hasCashout: json['hasCashout'] ?? false,
        invoiceType: json['type'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ticket": ticket,
        "title": title,
        "author": author,
        "invoice_reference": invoiceReference,
        "approval_status": approvalStatus,
        "total": total,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "hasCashout": hasCashout,
        "type": invoiceType,
      };
}
