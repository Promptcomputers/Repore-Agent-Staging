// To parse this JSON data, do
//
//     final loginRes = loginResFromJson(jsonString);

import 'dart:convert';

LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

String loginResToJson(LoginRes data) => json.encode(data.toJson());

class LoginRes {
  Data? data;

  LoginRes({
    this.data,
  });

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  String token;
  User? user;

  Data({
    required this.token,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] ?? '',
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
      };
}

class User {
  String firstname;
  String id;
  String email;
  String role;

  User({
    required this.firstname,
    required this.id,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstname: json["firstname"] ?? '',
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        role: json["role"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "id": id,
        "email": email,
        "role": role,
      };
}
