import 'package:flutter/material.dart';
import '../config/config.dart';
import '../service/service_method.dart';
import '../model/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProvide with ChangeNotifier {
  bool isLogin = false; // 是否登录
  bool isSignin = false; // 是否注册成功
  bool tokenErr = false;
  String loginResult; // 0登录成功，-1未知原因登陆失败，-2用户名或密码为空，-3用户名不存在，-4用户信息获取失败，-5密码不正确
  String signinResult; // 0注册成功，-1未知原因注册失败，-2用户名或密码为空，-3用户名已存在
  bool pwdShow = false; //密码是否显示明文
  String userInfoString = '''
    {
      "userName":"",
      "userAvatar":"",
      "token":"",
      "sex":""
    }
  ''';
  var userInfoJson;

  // 登录
  login(userName, password) async {
    var data = {"userName": userName, "password": password};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfoString = prefs.getString('userInfo');
    var initUserInfoString = '''
      {
        "userName":"",
        "userAvatar":"",
        "token":"",
        "sex":""
      }
    ''';
    var tempString =
        userInfoString == null ? initUserInfoString : userInfoString;
    userInfoJson = jsonDecode(tempString);
    await request('login', POST, data: data).then((val) {
      LoginModel loginRes = LoginModel.fromJson(val);
      loginResult = loginRes.msg;
      if (loginRes.code == 0) {
        var data = loginRes.data;
        saveUserInfo(
            userName: userName,
            avatar: data.userAvatar,
            token: data.token,
            sex: data.sex);
        isLogin = true;
      } else {
        saveUserInfo(userName: "", avatar: "", token: "", sex: "");
        isLogin = false;
      }
    });
    notifyListeners();
  }

  // 初始化获取用户信息
  initUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("userInfo") != null) {
      userInfoString = prefs.getString("userInfo");
      userInfoJson = jsonDecode(userInfoString);
      if (userInfoJson["userName"] != "") {
        isLogin = true;
      } else {
        isLogin = false;
      }
    } else {
      isLogin = false;
    }

    notifyListeners();
  }

  // 保存用户信息
  saveUserInfo({userName, avatar, token, sex}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfoJson["userName"] =
        userName == null ? userInfoJson["userName"] : userName;
    userInfoJson["avatar"] = avatar == null ? userInfoJson["avatar"] : avatar;
    userInfoJson["token"] = token == null ? userInfoJson["token"] : token;
    userInfoJson["sex"] = sex == null ? userInfoJson["sex"] : sex;
    userInfoString = jsonEncode(userInfoJson);
    prefs.setString("userInfo", userInfoString);
    notifyListeners();
  }

  // 修改用户信息
  updateUserInfo(sex) async {
    var data = {"token": userInfoJson["token"], "sex": sex};
    return await request('updateUserInfo', POST, data: data).then((val) {
      if (val['code'] == 0) {
        saveUserInfo(sex: sex);
        return true;
      } else if (val['code'] == -2) {
        tokenErr = true;
      }
      return false;
    });
  }

  // 注册
  signin(userName, password) async {
    var data = {"userName": userName, "password": password};
    return await request('signin', POST, data: data).then((val) {
      signinResult = val['msg'];
      if (val['code'] == 0) {
        return true;
      } else {
        return false;
      }
    });
  }

  // 退出登录
  logout() {
    saveUserInfo(userName: "", avatar: "", token: "", sex: "");
    isLogin = false;
    notifyListeners();
  }

  // 改变密码是否显示状态
  changePwdShow() {
    pwdShow = !pwdShow;
    notifyListeners();
  }
}
