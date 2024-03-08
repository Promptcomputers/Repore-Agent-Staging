// To parse this JSON data, do
//
//     final getUserTicketsRes = getUserTicketsResFromJson(jsonString);

import 'dart:convert';

GetUserTicketsRes getUserTicketsResFromJson(String str) =>
    GetUserTicketsRes.fromJson(json.decode(str));

String getUserTicketsResToJson(GetUserTicketsRes data) =>
    json.encode(data.toJson());

class GetUserTicketsRes {
  final List<Datum>? data;

  GetUserTicketsRes({
    this.data,
  });

  factory GetUserTicketsRes.fromJson(Map<String, dynamic> json) =>
      GetUserTicketsRes(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String reference;
  final Type? type;
  final String subject;
  final String author;
  final Customer? customer;
  final String status;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;

  Datum({
    required this.id,
    required this.reference,
    required this.type,
    required this.subject,
    required this.author,
    required this.customer,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] ?? '',
        reference: json["reference"] ?? '',
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        subject: json["subject"] ?? '',
        author: json["author"] ?? '',
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        status: json["status"] ?? '',
        description: json["description"] ?? '',
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
        "reference": reference,
        "type": type!.toJson(),
        "subject": subject,
        "author": author,
        "customer": customer!.toJson(),
        "status": status,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Customer {
  final String id;
  final String firstname;
  final String lastname;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final String email;
  final String password;
  final String phone;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;
  final String company;
  final dynamic otpReference;

  Customer({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.company,
    this.otpReference,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        address: json["address"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        zipcode: json["zipcode"] ?? '',
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
        company: json["company"] ?? '',
        otpReference: json["otp_reference"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "email": email,
        "password": password,
        "phone": phone,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "company": company,
        "otp_reference": otpReference,
      };
}

class Type {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;

  Type({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
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
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}
