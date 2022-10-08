class LoginModel {
  int? code;
  Msg? msg;
  Data? data;

  LoginModel({this.code, this.msg, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    if (json["code"] is int) {
      code = json["code"];
    }
    if (json["msg"] is Map) {
      msg = json["msg"] == null ? null : Msg.fromJson(json["msg"]);
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    if (msg != null) {
      data["msg"] = msg?.toJson();
    }
    if (this.data != null) {
      data["data"] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["token"] is String) {
      token = json["token"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    return data;
  }
}

class Msg {
  String? id;
  String? en;

  Msg({this.id, this.en});

  Msg.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["en"] is String) {
      en = json["en"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["en"] = en;
    return data;
  }
}
