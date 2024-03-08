import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repore_agent/lib.dart';

final paymentServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService((ref), ref);
});

class PaymentService {
  final Ref _read;
  final Ref ref;

  PaymentService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll(
      [
        ApiInterceptor(),
        ErrorInterceptor(),
        if (kDebugMode) ...[PrettyDioLogger()],
      ],
    );
  }

  ///Get all transaction for a user
  Future<GetAllTransactionRes> getAllTransactions() async {
    final url = 'payment/transactions';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return GetAllTransactionRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Add Bank details
  Future<bool> addBank(String accountNumber, String routingNumber,
      String accountName, bool isDefault, String ssn) async {
    // {user, routing_number, account_number, account_name, isDefault, ssn_last_4, ip_address}
    final url = 'payment/add-bank';
    try {
      final response = await _read.read(dioProvider).post(
            url,
            data: {
              "routing_number": routingNumber,
              "account_number": accountNumber,
              "account_name": accountName,
              "isDefault": isDefault,
              "ssn_last_4": ssn,
              "ip_address": '8.8.8.8',
            },
            options: Options(
              headers: {"requireToken": true},
            ),
          );
      return response.data == true;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Get user saved bank details
  Future<GetBankDetailRes> getSavedBankDetails() async {
    final url = 'payment/banks';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return GetBankDetailRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Delete bank details
  Future<bool> deleteBankDetail(String bankId) async {
    final url = 'payment/$bankId';
    try {
      final response = await _read.read(dioProvider).delete(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Get user balance
  Future<WalletBalanceRes> getUserBalance() async {
    final url = 'payment/balance';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return WalletBalanceRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Withdrawal
  Future<bool> withdrawal(String amount, String bankAccount, String pin) async {
    final url = 'payment/initialize-withdrawal';
    try {
      final response = await _read.read(dioProvider).post(
            url,
            data: {
              "amount": amount,
              "bank_id": bankAccount,
              "pin": pin,
            },
            options: Options(headers: {"requireToken": true}),
          );
      return response.data == true;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Cashout
  Future<bool> cashout(String invoiceId) async {
    final url = 'payment/cashout';
    try {
      final response = await _read.read(dioProvider).post(
            url,
            data: {
              "invoice_id": invoiceId,
            },
            options: Options(headers: {"requireToken": true}),
          );
      return response.data == true;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }
}
