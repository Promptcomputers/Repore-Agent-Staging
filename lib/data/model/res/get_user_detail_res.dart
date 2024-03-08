// To parse this JSON data, do
//
//     final userDetailRes = userDetailResFromJson(jsonString);

import 'dart:convert';

UserDetailRes userDetailResFromJson(String str) =>
    UserDetailRes.fromJson(json.decode(str));

String userDetailResToJson(UserDetailRes data) => json.encode(data.toJson());

class UserDetailRes {
  final UserData data;

  UserDetailRes({
    required this.data,
  });

  factory UserDetailRes.fromJson(Map<String, dynamic> json) => UserDetailRes(
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UserData {
  String id;
  String firstname;
  String lastname;
  String gender;
  DateTime dob;
  String email;
  String password;
  String phone;
  bool firstLogin;
  bool isProfileComplete;
  bool isAddressComplete;
  bool isPinProvided;
  bool isCardProvided;
  bool hasPasswordChanged;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  num v;
  String deviceToken;
  String stripeCustomerId;

  UserData({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phone,
    required this.firstLogin,
    required this.isProfileComplete,
    required this.isAddressComplete,
    required this.isCardProvided,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.deviceToken,
    required this.dob,
    required this.gender,
    required this.hasPasswordChanged,
    required this.isPinProvided,
    required this.stripeCustomerId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      id: json["_id"] ?? '',
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
      phone: json["phone"] ?? '',
      firstLogin: json["firstLogin"] ?? true,
      isProfileComplete: json["isProfileComplete"] ?? true,
      isAddressComplete: json["isAddressComplete"] ?? true,
      isCardProvided: json["isCardProvided"] ?? true,
      deviceToken: json['device_token'] ?? '',
      hasPasswordChanged: json['hasPasswordChanged'] ?? true,
      isPinProvided: json['isPinProvided'] ?? true,
      dob: json["dob"] == null ? DateTime.now() : DateTime.parse(json["dob"]),
      gender: json['gender:'] ?? '',
      role: json["role"] ?? '',
      createdAt: json["created_at"] == null
          ? DateTime.now()
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? DateTime.now()
          : DateTime.parse(json["updated_at"]),
      v: json["__v"] ?? 0,
      stripeCustomerId: json['stripe_account_id'] ?? '');

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "gender": gender,
        "dob": dob,
        "isPinProvided": isPinProvided,
        "hasPasswordChanged": hasPasswordChanged,
        "device_token": deviceToken,
        "phone": phone,
        "firstLogin": firstLogin,
        "isProfileComplete": isProfileComplete,
        "isAddressComplete": isAddressComplete,
        "isCardProvided": isCardProvided,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
        "stripe_account_id": stripeCustomerId,
      };
}
