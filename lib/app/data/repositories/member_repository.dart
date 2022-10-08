import 'package:cubit_core/app/data/models/login_model.dart';
import 'package:cubit_core/app/data/services/api_services.dart';

class MemberRepository {
  static Future<LoginModel?> login(Map<String, dynamic> data) async {
    try {
      var res = await ApiServices().POST("member/login", data, showLog: true);
      return LoginModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
