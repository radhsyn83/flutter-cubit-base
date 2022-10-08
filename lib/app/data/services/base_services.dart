// ignore_for_file: non_constant_identifier_names

mixin BaseService {
  Future<dynamic> GET(String url,
      {Map<String, dynamic>? query, showLog = false});
  Future<dynamic> POST(String url, Map<String, dynamic>? data,
      {showLog = false});
  Future<dynamic> PUT(String url, Map<String, dynamic>? data,
      {showLog = false});
  Future<dynamic> DELETE(String url,
      {Map<String, dynamic>? query, showLog = false});
}
