// To parse this JSON data, do
//
//     final updateProfileReq = updateProfileReqFromJson(jsonString);

import 'dart:convert';

UpdateProfileReq updateProfileReqFromJson(String str) =>
    UpdateProfileReq.fromJson(json.decode(str));

String updateProfileReqToJson(UpdateProfileReq data) =>
    json.encode(data.toJson());

class UpdateProfileReq {
  final String company;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final String gender;
  final String dateOfBirth;
  final String phoneNo;

  UpdateProfileReq({
    required this.company,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.gender,
    required this.dateOfBirth,
    required this.phoneNo,
  });

  factory UpdateProfileReq.fromJson(Map<String, dynamic> json) =>
      UpdateProfileReq(
        company: json["company"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        gender: json["gender"],
        dateOfBirth: json['dob'],
        phoneNo: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "gender": gender,
        "dob": dateOfBirth,
        "phone": phoneNo,
      };
}
