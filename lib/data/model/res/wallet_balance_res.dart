// To parse this JSON data, do
//
//     final walletBalanceRes = walletBalanceResFromJson(jsonString);

import 'dart:convert';

WalletBalanceRes walletBalanceResFromJson(String str) =>
    WalletBalanceRes.fromJson(json.decode(str));

String walletBalanceResToJson(WalletBalanceRes data) =>
    json.encode(data.toJson());

class WalletBalanceRes {
  num? data;

  WalletBalanceRes({
    this.data,
  });

  factory WalletBalanceRes.fromJson(Map<String, dynamic> json) =>
      WalletBalanceRes(
        data: json["data"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
