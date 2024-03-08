// To parse this JSON data, do
//
//     final getSingleTicketWithFiles = getSingleTicketWithFilesFromJson(jsonString);

import 'dart:convert';

GetSingleTicketWithFiles getSingleTicketWithFilesFromJson(String str) =>
    GetSingleTicketWithFiles.fromJson(json.decode(str));

String getSingleTicketWithFilesToJson(GetSingleTicketWithFiles data) =>
    json.encode(data.toJson());

class GetSingleTicketWithFiles {
  final SingleTicketData? data;

  GetSingleTicketWithFiles({
    this.data,
  });

  factory GetSingleTicketWithFiles.fromJson(Map<String, dynamic> json) =>
      GetSingleTicketWithFiles(
        data: SingleTicketData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class SingleTicketData {
  final Ticket ticket;
  final List<FileElement> files;

  SingleTicketData({
    required this.ticket,
    required this.files,
  });

  factory SingleTicketData.fromJson(Map<String, dynamic> json) =>
      SingleTicketData(
        ticket: Ticket.fromJson(json["ticket"]),
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ticket": ticket.toJson(),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
      };
}

class FileElement {
  final String id;
  final String name;
  // final String? ticket;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileElement({
    required this.id,
    required this.name,
    // this.ticket,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        // ticket: json["ticket"] ?? '',
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        // "ticket": ticket,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Ticket {
  final String id;
  final String reference;
  final FileElement type;
  final String subject;
  final String author;
  final GetTicketCustomer customer;
  final String status;
  // final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Agent? agent;

  Ticket({
    required this.id,
    required this.reference,
    required this.type,
    required this.subject,
    required this.author,
    required this.customer,
    required this.status,
    // required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.agent,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["_id"] ?? '',
        reference: json["reference"] ?? '',
        type: FileElement.fromJson(json["type"]),
        subject: json["subject"] ?? '',
        author: json["author"],
        customer: GetTicketCustomer.fromJson(json["customer"]),
        status: json["status"] ?? '',
        // description: json["description"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "reference": reference,
        "type": type.toJson(),
        "subject": subject,
        "author": author,
        "customer": customer.toJson(),
        "status": status,
        // "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "agent": agent!.toJson(),
      };
}

class Agent {
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

  Agent({
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
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
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
        v: json["__v"],
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
      };
}

class GetTicketCustomer {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String phone;
  final String role;
  final bool isProfileComplete;
  final bool isAddressComplete;
  final bool isCardProvided;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;
  final String? stripeCustomerId;
  final String? otpReference;

  GetTicketCustomer({
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
    required this.isAddressComplete,
    required this.isCardProvided,
    required this.isProfileComplete,
    this.otpReference,
    this.stripeCustomerId,
  });

  factory GetTicketCustomer.fromJson(Map<String, dynamic> json) =>
      GetTicketCustomer(
        id: json["_id"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        phone: json["phone"] ?? '',
        role: json["role"] ?? '',
        isAddressComplete: json['isAddressComplete'] ?? true,
        isCardProvided: json['isCardProvided'] ?? true,
        isProfileComplete: json['isProfileComplete'] ?? true,
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"] ?? 0,
        otpReference: json["otp_reference"] ?? '',
        stripeCustomerId: json['stripe_customer_id'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "phone": phone,
        "role": role,
        "isAddressComplete": isAddressComplete,
        "isCardProvided": isCardProvided,
        "isProfileComplete": isProfileComplete,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "otp_reference": otpReference,
        "stripeCustomerId": stripeCustomerId,
      };
}
