import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repore_agent/lib.dart';

final invoiceServiceProvider = Provider<InvoiceService>((ref) {
  return InvoiceService((ref), ref);
});

class InvoiceService {
  final Ref _read;
  final Ref ref;

  InvoiceService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll(
      [
        ApiInterceptor(),
        ErrorInterceptor(),
        if (kDebugMode) ...[PrettyDioLogger()],
      ],
    );
  }

  ///Get all invoice for a ticket
  Future<AllTicketInvoiceRes> getTickeListOfInvoices(String ticketId) async {
    final url = 'invoice/all/$ticketId';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return AllTicketInvoiceRes.fromJson(response.data);
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

  ///Get invoice details and preview
  Future<InvoiceDetailsRes> getInvoiceDetails(String invoiceId) async {
    final url = 'invoice/$invoiceId';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return InvoiceDetailsRes.fromJson(response.data);
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

  ///Create an invoice for a ticket
  Future<bool> createInvoice(CreateInvoiceReq createInvoiceReq) async {
    const url = 'invoice/create-invoice';
    try {
      final response = await _read.read(dioProvider).post(
            url,
            data: createInvoiceReq.toJson(),
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
