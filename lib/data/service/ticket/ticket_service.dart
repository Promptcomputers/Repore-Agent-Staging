import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repore_agent/lib.dart';

final ticketServiceProvider = Provider<TicketService>((ref) {
  return TicketService((ref), ref);
});

class TicketService {
  final Ref _read;
  final Ref ref;

  TicketService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll(
      [
        ApiInterceptor(),
        ErrorInterceptor(),
        if (kDebugMode) ...[PrettyDioLogger()],
      ],
    );
  }

  ///Get user tickets
  Future<GetUserTicketsRes> getUserTicket(String userId, [search = '']) async {
    const url = 'tickets/all';
    var queryParameters = {
      "search": search,
    };
    try {
      final response = await _read.read(dioProvider).get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: {"requireToken": true}),
          );
      return GetUserTicketsRes.fromJson(response.data);
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

  ///Get single tickets
  Future<GetSingleTicketWithFiles> getSingleTicket(String userId) async {
    final url = 'tickets/$userId';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return GetSingleTicketWithFiles.fromJson(response.data);
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

  ///Get ticket messages
  Future<GetTicketMessages> getTicketMessages(String tickeId) async {
    final url = 'messages/$tickeId';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return GetTicketMessages.fromJson(response.data);
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

  ///Send message
  Future<bool> sendTicketMessage(
      String filesPath, String ticketId, String userId, String message) async {
    File file = File(filesPath);
    final mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');
    const url = 'messages/create';

    FormData formData = FormData.fromMap({
      // "files": await MultipartFile.fromFile(file.path,
      //     contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),

      "files": filesPath.isNotEmpty
          ? await MultipartFile.fromFile(file.path,
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1]))
          : "",
      "ticket": ticketId,
      "from": userId,
      "message": message,
    });

    try {
      final response = await _read.read(dioProvider).post(
            url,
            data: formData,
            options: Options(headers: {"requireToken": true}),
          );
      return response.data = true;
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
