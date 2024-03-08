// To parse this JSON data, do
//
//     final getTicketMessages = getTicketMessagesFromJson(jsonString);

import 'dart:convert';

GetTicketMessages getTicketMessagesFromJson(String str) =>
    GetTicketMessages.fromJson(json.decode(str));

String getTicketMessagesToJson(GetTicketMessages data) =>
    json.encode(data.toJson());

class GetTicketMessages {
  final List<MessageDatum> data;

  GetTicketMessages({
    required this.data,
  });

  factory GetTicketMessages.fromJson(Map<String, dynamic> json) =>
      GetTicketMessages(
        data: List<MessageDatum>.from(
            json["data"].map((x) => MessageDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MessageDatum {
  final String id;
  final String invoiceId;
  final num? invoiceTotal;
  final String invoiceType;
  final String type;
  final String? message;
  final String ticket;
  final From? from;
  final From? to;

  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;
  final MessageAttachment? attachment;

  MessageDatum({
    required this.id,
    required this.invoiceId,
    required this.invoiceTotal,
    required this.type,
    required this.message,
    required this.ticket,
    required this.from,
    this.to,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.attachment,
    required this.invoiceType,
  });

  factory MessageDatum.fromJson(Map<String, dynamic> json) => MessageDatum(
        id: json["_id"] ?? '',
        invoiceId: json["invoice_id"] ?? '',
        invoiceTotal: json["invoice_total"] ?? null,
        type: json["type"] ?? "",
        message: json["message"] ?? '',
        ticket: json["ticket"] ?? '',
        from: json["from"] == null ? null : From.fromJson(json["from"]),
        to: json["to"] == null ? null : From.fromJson(json["to"]),
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
        attachment: json["attachment"] == null
            ? null
            : MessageAttachment.fromJson(json["attachment"]),
        invoiceType: json['invoice_type'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "invoiceId": invoiceId,
        "invoiceTotal": invoiceTotal,
        "type": type,
        "message": message,
        "ticket": ticket,
        "from": from!.toJson(),
        "to": to?.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "attachment": attachment?.toJson(),
        "invoice_type": invoiceType,
      };
}

class MessageAttachment {
  final String? id;
  final String? name;
  final String? ticket;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  MessageAttachment({
    required this.id,
    required this.name,
    required this.ticket,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MessageAttachment.fromJson(Map<String, dynamic> json) =>
      MessageAttachment(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        ticket: json["ticket"] ?? '',
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "ticket": ticket,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class From {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String phone;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;
  final String? address;
  final String? city;
  final String? state;
  final String? zipcode;
  final String? company;
  final dynamic otpReference;

  From({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    this.company,
    this.otpReference,
  });

  factory From.fromJson(Map<String, dynamic> json) => From(
        id: json["_id"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        phone: json["phone"] ?? '',
        role: json["role"] ?? '',
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"] ?? 0,
        address: json["address"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        zipcode: json["zipcode"] ?? '',
        company: json["company"] ?? '',
        otpReference: json["otp_reference"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "phone": phone,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "company": company,
        "otp_reference": otpReference,
      };
}
