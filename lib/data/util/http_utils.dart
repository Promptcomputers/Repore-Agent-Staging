import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repore_agent/lib.dart';

class HttpUtils {
  static final BaseOptions options = BaseOptions(
    // connectTimeout: 100000,
    connectTimeout: 999990,
    receiveTimeout: 89250,
  );

  static Dio getInstance() {
    Dio dio = Dio(options)
      ..interceptors.add(PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
          error: true,
          maxWidth: 90));
    return dio;
  }

  static Future<DioError> buildErrorResponse(DioError err) async {
    switch (err.type) {
      case DioErrorType.connectTimeout:
        if (await ConnectionUtils.getActiveStatus()) {
          err.error = HttpErrorStrings.connectionTimeOutActive;
        } else {
          err.error = HttpErrorStrings.connectionTimeOutNotActive;
        }
        break;
      case DioErrorType.sendTimeout:
        err.error = HttpErrorStrings.sendTimeOut;
        break;
      case DioErrorType.receiveTimeout:
        err.error = HttpErrorStrings.receiveTimeOut;
        break;
      case DioErrorType.response:
        err.error = _handleError(err.response!.statusCode, err.response!.data);
        // if (err.response!.statusCode == HttpStatus.badRequest) {
        //   err.error = err.response!.data.toString();
        // } else if (err.response!.statusCode == HttpStatus.unauthorized) {
        //   err.error = 'Unauthorized';
        // } else if (err.response!.statusCode == HttpStatus.internalServerError) {
        //   err.error = 'i am hetre';
        //   // _handleError(err.response!.statusCode, err.response!.data);
        //   // err.error = HttpErrorStrings.badResponse;
        // } else {
        //   err.error =
        //       _handleError(err.response!.statusCode, err.response!.data);
        // }
        break;
      case DioErrorType.cancel:
        err.error = HttpErrorStrings.opeartionCancelled;
        break;
      case DioErrorType.other:
        // err.error = _handleError(err.response!.statusCode, err.response!.data);
        if (!await ConnectionUtils.getActiveStatus()) {
          err.error = HttpErrorStrings.defaultError;
        } else {
          err.error =
              _handleError(err.response!.statusCode, err.response!.data);
          // err.error = HttpErrorStrings.badResponse;
        }
        break;
      default:
        err.error = HttpErrorStrings.unknownError;
        break;
    }

    return err;
  }
}

String _handleError(int? statusCode, dynamic error) {
  switch (statusCode) {
    case 400:
      return handleError(error);
    case 401:
      return "An Error occurred.Try again later";
    // return error["message"];
    case 424:
      return "An Error occurred.Try again later";
    // return error["message"];
    case 403:
      // FailureRes result = FailureRes.fromJson(error);
      return "Error occurred";
    case 404:
      return handleError(error);
    case 500:
      return "An Error occurred.Try again later";
    case 502:
      return "Bad gateway";
    case 504:
      return "Service unavaiilable. Please try again later";
    default:
      return "Oops something went wrong";
  }
}

String handleError(dynamic errors) {
  if (errors["errors"] != null) {
    FailureModelRes result = FailureModelRes.fromJson(errors);
    if (result.errors.isNotEmpty) {
      result.errors.forEach((error) {
        errors = error.message.toString();
      });
    }
    return errors.toString();
  } else {
    return errors["message"];
  }
}
