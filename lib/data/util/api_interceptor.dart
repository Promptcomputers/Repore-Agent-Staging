import 'package:dio/dio.dart';
import 'package:repore_agent/lib.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = PreferenceManager.token;

    if (options.headers.containsKey('requireToken')) {
      options.headers.addAll({"Authorization": "Bearer $token"});
      // remove the auxilliary header
      options.headers.remove('requireToken');
    } else {
      options.headers.remove('requireToken');
    }

    log("Headers:");
    options.headers.forEach((k, v) => log('$k: $v'));
    // ignore: unnecessary_null_comparison
    if (options.queryParameters != null) {
      log("queryParameters:");
      options.queryParameters.forEach((k, v) => log('$k: $v'));
    }
    if (options.data != null) {
      log("Body: ${options.data}");
    }
    log(
        // ignore: unnecessary_null_comparison
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    // options.headers.addAll({"X-Api-Key": "${Globals.xAPIKey}"});

    return super.onRequest(options, handler);
  }
}

@override
Future onResponse(Response response, ResponseInterceptorHandler handler) async {
  // print('RESPONSE[${response.statusCode}] => PATH: ${response.request?.path}');
  log("Headers:");
  response.headers.forEach((k, v) => log('$k: $v'));
  log("Response: ${response.data}");
  log("<-- END HTTP");
  // }
  return handler.next(response);
}
