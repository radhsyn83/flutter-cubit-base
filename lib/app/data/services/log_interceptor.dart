// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH:  ${options.uri}');
    if (options.queryParameters.isNotEmpty) {
      print('REQUEST["QUERY"] => ${options.queryParameters}');
    }
    if (options.data != null) print('REQUEST["DATA"] => ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}');
    print('RESPONSE[${"BODY"}] => ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}');
    print('RESPONSE[${"BODY"}] => ${err.response}');
    return super.onError(err, handler);
  }
}
