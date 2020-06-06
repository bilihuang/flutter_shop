class LoginModel {
  int code;
  String msg;
  LoginData data;

  LoginModel({this.code, this.msg, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class LoginData {
  String token;
  String userAvatar;
  String sex;

  LoginData({this.token, this.userAvatar});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userAvatar = json['userAvatar'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userAvatar'] = this.userAvatar;
    data['sex'] = this.sex;
    return data;
  }
}
