// To parse this JSON data, do
//
//     final createInvoiceReq = createInvoiceReqFromJson(jsonString);

import 'dart:convert';

CreateInvoiceReq createInvoiceReqFromJson(String str) =>
    CreateInvoiceReq.fromJson(json.decode(str));

String createInvoiceReqToJson(CreateInvoiceReq data) =>
    json.encode(data.toJson());

class CreateInvoiceReq {
  String ticket;
  String title;
  DateTime dueDate;
  String notes;
  List<dynamic> fields;
  String type;

  CreateInvoiceReq({
    required this.ticket,
    required this.title,
    required this.dueDate,
    required this.notes,
    required this.fields,
    required this.type,
  });

  factory CreateInvoiceReq.fromJson(Map<String, dynamic> json) =>
      CreateInvoiceReq(
        ticket: json["ticket"],
        title: json["title"],
        dueDate: DateTime.parse(json["due_date"]),
        notes: json["notes"],
        type: json['type'],
        fields: json['type'] == "SERVICE"
            ? List<ServiceField>.from(
                json["fields"].map((x) => Field.fromJson(x)))
            : List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ticket": ticket,
        "title": title,
        "due_date": dueDate.toIso8601String(),
        "notes": notes,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "type": type,
      };
}

class Field {
  String description;
  num quantity;
  num price;

  Field({
    required this.description,
    required this.quantity,
    required this.price,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "quantity": quantity,
        "price": price,
      };
}

class ServiceField {
  String work;
  num hourly;
  num totalHour;

  ServiceField({
    required this.work,
    required this.hourly,
    required this.totalHour,
  });

  factory ServiceField.fromJson(Map<String, dynamic> json) => ServiceField(
        work: json["work"],
        hourly: json["hourly_rate"],
        totalHour: json["total_hours"],
      );

  Map<String, dynamic> toJson() => {
        "work": work,
        "hourly_rate": hourly,
        "total_hours": totalHour,
      };
}
