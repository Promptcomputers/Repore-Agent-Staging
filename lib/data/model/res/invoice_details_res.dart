// To parse this JSON data, do
//
//     final invoiceDetailsRes = invoiceDetailsResFromJson(jsonString);

import 'dart:convert';

InvoiceDetailsRes invoiceDetailsResFromJson(String str) =>
    InvoiceDetailsRes.fromJson(json.decode(str));

String invoiceDetailsResToJson(InvoiceDetailsRes data) =>
    json.encode(data.toJson());

class InvoiceDetailsRes {
  InvoiceDetailData data;

  InvoiceDetailsRes({
    required this.data,
  });

  factory InvoiceDetailsRes.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailsRes(
        data: InvoiceDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class InvoiceDetailData {
  String id;
  String title;
  num? taxCharge;
  num? serviceCharge;
  InvoiceTicket? ticket;
  Author? author;
  InvoiceCustomer? customer;
  String invoiceReference;
  DateTime dueDate;
  String notes;
  String approvalStatus;
  num subTotal;
  num total;
  // List<Detail> details;
  DateTime createdAt;
  DateTime updatedAt;
  num v;
  bool hasCashout;
  String type;
  List<AcquisitionDetails> acquisitionDetails;
  List<ServiceDetails> serviceDetails;

  InvoiceDetailData({
    required this.id,
    required this.title,
    required this.taxCharge,
    required this.serviceCharge,
    required this.ticket,
    required this.author,
    required this.customer,
    required this.invoiceReference,
    required this.dueDate,
    required this.notes,
    required this.approvalStatus,
    required this.subTotal,
    required this.total,
    // required this.details,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.acquisitionDetails,
    required this.hasCashout,
    required this.serviceDetails,
    required this.type,
  });

  factory InvoiceDetailData.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailData(
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        taxCharge: json["tax_charge"] ?? 0,
        serviceCharge: json["service_charge"] ?? 0,
        ticket: json["ticket"] == null
            ? null
            : InvoiceTicket.fromJson(json["ticket"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        customer: json["customer"] == null
            ? null
            : InvoiceCustomer.fromJson(json["customer"]),
        invoiceReference: json["invoice_reference"] ?? '',
        dueDate: json["due_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["due_date"]),
        notes: json["notes"] ?? '',
        approvalStatus: json["approval_status"] ?? '',
        subTotal: json["sub_total"] ?? 0,
        total: json["total"] ?? 0,
        // details: json["details"] == null
        //     ? []
        //     : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"] ?? 0,
        acquisitionDetails: json["acquisition_details"] == null
            ? []
            : List<AcquisitionDetails>.from(
                json["acquisition_details"].map(
                  (x) => AcquisitionDetails.fromJson(x),
                ),
              ),
        serviceDetails: json["service_details"] == null
            ? []
            : List<ServiceDetails>.from(
                json["service_details"].map(
                  (x) => ServiceDetails.fromJson(x),
                ),
              ),
        hasCashout: json['hasCashout'] ?? false,
        type: json['type'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "tax_charge": taxCharge,
        "service_charge": serviceCharge,
        "ticket": ticket!.toJson(),
        "author": author!.toJson(),
        "customer": customer!.toJson(),
        "invoice_reference": invoiceReference,
        "due_date": dueDate.toIso8601String(),
        "notes": notes,
        "approval_status": approvalStatus,
        "sub_total": subTotal,
        "total": total,
        // "details": List<dynamic>.from(details.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "type": type,
        "hasCashout": hasCashout,
        "service_details":
            List<dynamic>.from(serviceDetails.map((x) => x.toJson())),
        "acquisition_details":
            List<dynamic>.from(acquisitionDetails.map((x) => x.toJson())),
      };
}

class Author {
  String id;
  String firstname;
  String lastname;
  String stripeCustomerId;
  String email;
  String password;
  String phone;
  bool isProfileComplete;
  bool isAddressComplete;
  bool isCardProvided;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  num v;

  Author({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.stripeCustomerId,
    required this.email,
    required this.password,
    required this.phone,
    required this.isProfileComplete,
    required this.isAddressComplete,
    required this.isCardProvided,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        stripeCustomerId: json["stripe_customer_id"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        phone: json["phone"] ?? '',
        isProfileComplete: json["isProfileComplete"] ?? true,
        isAddressComplete: json["isAddressComplete"] ?? true,
        isCardProvided: json["isCardProvided"] ?? true,
        role: json["role"] ?? '',
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
        "firstname": firstname,
        "lastname": lastname,
        "stripe_customer_id": stripeCustomerId,
        "email": email,
        "password": password,
        "phone": phone,
        "isProfileComplete": isProfileComplete,
        "isAddressComplete": isAddressComplete,
        "isCardProvided": isCardProvided,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class InvoiceCustomer {
  String id;
  String firstname;
  String lastname;
  String email;
  String password;
  String phone;
  bool isProfileComplete;
  bool isAddressComplete;
  bool isCardProvided;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  num v;
  String deviceToken;
  String address;
  String city;
  String company;
  String state;
  String zipcode;

  InvoiceCustomer({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phone,
    required this.isProfileComplete,
    required this.isAddressComplete,
    required this.isCardProvided,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.deviceToken,
    required this.address,
    required this.city,
    required this.company,
    required this.state,
    required this.zipcode,
  });

  factory InvoiceCustomer.fromJson(Map<String, dynamic> json) =>
      InvoiceCustomer(
        id: json["_id"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        phone: json["phone"] ?? '',
        isProfileComplete: json["isProfileComplete"] ?? true,
        isAddressComplete: json["isAddressComplete"] ?? true,
        isCardProvided: json["isCardProvided"] ?? true,
        role: json["role"] ?? '',
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        v: json["__v"] ?? 0,
        deviceToken: json["device_token"] ?? '',
        address: json["address"] ?? '',
        city: json["city"] ?? '',
        company: json["company"] ?? '',
        state: json["state"] ?? '',
        zipcode: json["zipcode"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "phone": phone,
        "isProfileComplete": isProfileComplete,
        "isAddressComplete": isAddressComplete,
        "isCardProvided": isCardProvided,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "device_token": deviceToken,
        "address": address,
        "city": city,
        "company": company,
        "state": state,
        "zipcode": zipcode,
      };
}

class AcquisitionDetails {
  final String id;
  final String description;
  final num quantity;
  final num price;

  AcquisitionDetails({
    required this.id,
    required this.description,
    required this.quantity,
    required this.price,
  });

  factory AcquisitionDetails.fromJson(Map<String, dynamic> json) =>
      AcquisitionDetails(
        id: json["_id"] ?? '',
        description: json["description"] ?? '',
        quantity: json["quantity"] ?? 0,
        price: json["price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "quantity": quantity,
        "price": price,
      };
}

class ServiceDetails {
  final String id;
  final String work;
  final num hourlyRate;
  final num totalHour;

  ServiceDetails({
    required this.id,
    required this.work,
    required this.hourlyRate,
    required this.totalHour,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
        id: json["_id"] ?? '',
        work: json["work"] ?? '',
        hourlyRate: json["hourly_rate"] ?? 0,
        totalHour: json["total_hours"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "work": work,
        "hourly_rate": hourlyRate,
        "total_hours": totalHour,
      };
}

// class Detail {
//   String description;
//   int quantity;
//   int price;
//   String id;

//   Detail({
//     required this.description,
//     required this.quantity,
//     required this.price,
//     required this.id,
//   });

//   factory Detail.fromJson(Map<String, dynamic> json) => Detail(
//         description: json["description"] ?? '',
//         quantity: json["quantity"] ?? 0,
//         price: json["price"] ?? 0,
//         id: json["_id"] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         "description": description,
//         "quantity": quantity,
//         "price": price,
//         "_id": id,
//       };
// }

class InvoiceTicket {
  String id;
  String reference;
  String type;
  String subject;
  String author;
  String customer;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  num v;

  InvoiceTicket({
    required this.id,
    required this.reference,
    required this.type,
    required this.subject,
    required this.author,
    required this.customer,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory InvoiceTicket.fromJson(Map<String, dynamic> json) => InvoiceTicket(
        id: json["_id"] ?? '',
        reference: json["reference"] ?? '',
        type: json["type"] ?? '',
        subject: json["subject"] ?? '',
        author: json["author"] ?? '',
        customer: json["customer"] ?? '',
        status: json["status"] ?? '',
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
        "type": type,
        "subject": subject,
        "author": author,
        "customer": customer,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}
