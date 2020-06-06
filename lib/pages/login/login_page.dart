import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/toast.dart';
import 'package:provide/provide.dart';
import '../../provide/user.dart';
import '../../routers/application.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 保存用户名和密码
  String _userName = "";
  String _password = "";
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  FocusNode _blankFocus = FocusNode(); // 点击空白处的焦点

  GlobalKey _formKey = new GlobalKey<FormState>();

  bool isPwdShow = false; // 是否显示密码

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // 移除焦点监听
    _unameController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var loginResult =
    //     Provide.value<UserProvide>(context).login("baixing", "123456");
    // print(loginResult);
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Provide<UserProvide>(builder: (context, child, val) {
        return GestureDetector(
          onTap: () {
            // 点击空白区域回收键盘
            FocusScope.of(context).requestFocus(_blankFocus);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                _logoImageArea(),
                _form(context),
                _loginBtn(context),
                _signin(context)
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _logoImageArea() {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30, bottom: 20),
        child: Image.asset(
          'imgs/logo.png',
          width: ScreenUtil().setWidth(220),
          fit: BoxFit.fill,
        ));
  }

  Widget _form(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
          key: _formKey,
          // autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: false,
                controller: _unameController,
                decoration: InputDecoration(
                    labelText: '用户名',
                    hintText: '请输入用户名',
                    prefixIcon: Icon(Icons.person)),
                // 校验用户名（不能为空）
                validator: (v) {
                  return v.trim().isNotEmpty ? null : '用户名不能为空';
                },
                onSaved: (value) {
                  _userName = value;
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '请输入密码',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(isPwdShow
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isPwdShow = !isPwdShow;
                          });
                        })),
                obscureText: !isPwdShow,
                //校验密码（不能为空）
                validator: (v) {
                  var password = v.trim();
                  if (password.isEmpty) {
                    return "密码不能为空";
                  } else if (password.length < 6 || password.length > 18) {
                    return "密码长度必须为6~18位";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
            ],
          )),
    );
  }

  Widget _loginBtn(context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(500),
      height: ScreenUtil().setHeight(100),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () async {
          // 点击登录回收键盘
          FocusScope.of(context).requestFocus(_blankFocus);
          if ((_formKey.currentState as FormState).validate()) {
            // 保存数据
            (_formKey.currentState as FormState).save();
            await Provide.value<UserProvide>(context)
                .login(_userName, _password);
            if (Provide.value<UserProvide>(context).isLogin) {
              showToast("登录成功");
              Navigator.of(context).pop(); // 登录成功回到上一页
            } else {
              String loginResult =
                  Provide.value<UserProvide>(context).loginResult;
              showToast(loginResult);
            }
          }
        },
        child: Text(
          '登   录',
          style: TextStyle(fontSize: ScreenUtil().setSp(36)),
        ),
      ),
    );
  }

  Widget _signin(context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      alignment: Alignment.topCenter,
      child: InkWell(
        child: Text(
          "还没有账号？前往注册",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: ScreenUtil().setSp(30)),
        ),
        onTap: () {
          Application.router.navigateTo(context, '/signin');
        },
      ),
    );
  }
}
