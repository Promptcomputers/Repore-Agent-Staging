import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repore_agent/lib.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService((ref), ref);
});

final dioProvider = Provider(
  (ref) => Dio(
    BaseOptions(
      receiveTimeout: 100000,
      connectTimeout: 100000,
      baseUrl: AppConfig.coreBaseUrl,
    ),
  ),
);

class AuthService {
  final Ref _read;
  final Ref ref;

  AuthService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll(
      [
        ApiInterceptor(),
        ErrorInterceptor(),
        if (kDebugMode) ...[PrettyDioLogger()],
      ],
    );
  }

  ///Login
  Future<LoginRes> login(
      {required String email,
      required String password,
      required String deviceToken}) async {
    const url = 'auth/login';
    try {
      final response = await _read.read(dioProvider).post(
        url,
        data: {
          "email": email,
          "password": password,
          "device_token": deviceToken,
        },
      );
      return LoginRes.fromJson(response.data);
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
