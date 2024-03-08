import 'package:dio/dio.dart';
import 'package:repore_agent/lib.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    err = await HttpUtils.buildErrorResponse(err);

    // if (err.response?.requestOptions.path != "/auth/sign-in" &&
    //     err.response?.requestOptions.path != "/auth/sign-in-new" &&
    //     err.response?.statusCode == 401) {
    //   eventBus.fire(UnAuthenticated());
    // }
    return super.onError(err, handler);
  }
}
