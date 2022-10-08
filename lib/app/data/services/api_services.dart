// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cubit_core/app/data/services/base_services.dart';
import 'package:cubit_core/app/data/services/log_interceptor.dart';
import 'package:cubit_core/app/utils/error.dart';
import 'package:cubit_core/constantas.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:package_info/package_info.dart';

class ApiServices with BaseService {
  final dio = Dio(BaseOptions(
    baseUrl: "${Constanta.BASE_URL}/",
    connectTimeout: 10000, //milisecond
    receiveTimeout: 5000, //milisecond
    headers: {
      HttpHeaders.acceptHeader: "accept: application/json",
    },
  ));

  @override
  Future GET(String url,
      {Map<String, dynamic>? query, showLog = false, retries = 3}) async {
    //interceptor
    if (showLog) dio.interceptors.add(CustomInterceptors());
    dio.interceptors
        .add(RetryInterceptor(dio: dio, retries: retries, logPrint: print));
    //header
    var headers = await _getHeader();
    var opt = Options(headers: headers);
    return _callDio(dio.get(url, options: opt, queryParameters: query));
  }

  @override
  Future POST(String url, Map<String, dynamic>? data, {showLog = false}) async {
    //interceptor
    if (showLog) dio.interceptors.add(CustomInterceptors());
    dio.interceptors
        .add(RetryInterceptor(dio: dio, retries: 0, logPrint: print));
    //header
    var headers = await _getHeader();
    var opt = Options(headers: headers);
    return _callDio(dio.post(url, options: opt, data: data));
  }

  @override
  Future PUT(String url, Map<String, dynamic>? data, {showLog = false}) async {
    //interceptor
    if (showLog) dio.interceptors.add(CustomInterceptors());
    dio.interceptors
        .add(RetryInterceptor(dio: dio, retries: 0, logPrint: print));
    //header
    var headers = await _getHeader();
    var opt = Options(headers: headers);
    return _callDio(dio.put(url, options: opt, data: data));
  }

  @override
  Future DELETE(String url,
      {Map<String, dynamic>? query, showLog = false}) async {
    //interceptor
    if (showLog) dio.interceptors.add(CustomInterceptors());
    dio.interceptors
        .add(RetryInterceptor(dio: dio, retries: 0, logPrint: print));
    //header
    var headers = await _getHeader();
    var opt = Options(headers: headers);
    return _callDio(dio.delete(url, options: opt, queryParameters: query));
  }

  Future<void> _callDio(Future<Response> future) async {
    dynamic responseJson;
    try {
      await future.then((res) => responseJson = _filterResponse(res.data));
    } on DioError catch (e) {
      _dioThrow(e);
    } on SocketException {
      throw _errorException(ErrorType.noConnection);
    }
    return responseJson;
  }

  Future<Map<String, String>> _getHeader() async {
    final Map<String, String> map = {};
    var platform = "";

    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isIOS) {
      platform = "ios";
    } else {
      platform = "other";
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    map["version"] = "${packageInfo.version}${packageInfo.buildNumber}";

    // map["Content-Type"] = "application/json";
    // await LocalStorage.token.then((token) {
    //   if (token != null) {
    //     map["Authorization"] = token;
    //   }
    // });
    map["os"] = platform;
    return map;
  }

  void _dioThrow(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        throw _errorException(ErrorType.requestTimeOut);
      case DioErrorType.sendTimeout:
        throw _errorException(ErrorType.requestTimeOut);
      default:
        throw _errorException(ErrorType.somethingWrong, msg: e.response?.data);
    }
  }

  Future<dynamic> _filterResponse(json) async {
    var code = json["code"].toString();

    if (code == "200") {
      return json;
    } else {
      throw _customMessage(ErrorType.notFound, json);
    }
  }

  ErrorModel _customMessage(error, json) {
    var code = json["code"].toString();
    var msg = json["msg"]["id"].toString();
    var err = ErrorType.somethingWrong;

    switch (code) {
      // case "1002":
      //   LocalStorage.logout(openMain: false);
      //   err.msg = msg;
      //   return err;
      // case "888":
      //   return _errorException(error, msg: "Data tidak ditemukan");
      // case "2404":
      //   return _errorException(error, msg: "Tidak ada produk yang ditemukan.");
      // case "1009":
      //   return _errorException(error, msg: "Tidak ada invoice yang ditemukan");
      // case "1012":
      //   return _errorException(error, msg: "Tidak ada Order yang ditemukan");
      default:
        err.msg = msg;
        return err;
    }
  }

  ErrorModel _errorException(
    ErrorModel err, {
    String? msg,
  }) {
    if (msg != null) {
      err.msg = msg;
    }
    return err;
  }
}
