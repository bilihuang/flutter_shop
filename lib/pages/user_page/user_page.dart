import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';
import '../../utils/toast.dart';
import 'package:provide/provide.dart';
import '../../provide/user.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人信息"),
      ),
      body: Provide<UserProvide>(
        builder: (context, chils, val) {
          return Container(
            child: Column(
              children: <Widget>[_avatar(context), _info(context)],
            ),
          );
        },
      ),
    );
  }

  Widget _avatar(context) {
    String avatarUrl =
        Provide.value<UserProvide>(context).userInfoJson['avatar'];
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: Colors.black),
      ),
      child: CircleAvatar(
        radius: ScreenUtil().setWidth(100),
        backgroundImage: NetworkImage(avatarUrl),
      ),
    );
  }

  // 用户信息
  Widget _info(context) {
    String userName =
        Provide.value<UserProvide>(context).userInfoJson['userName'];
    String sex = Provide.value<UserProvide>(context).userInfoJson['sex'];
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  )),
            ),
            child: ListTile(
              leading: Text(
                '用户名',
                style: TextStyle(fontSize: ScreenUtil().setSp(36)),
              ),
              title: Text(userName,
                  style: TextStyle(fontSize: ScreenUtil().setSp(36))),
              contentPadding: EdgeInsets.only(left: 20),
              enabled: false,
              onTap: () {
                print("点击了我的地址");
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                width: 1,
                color: Colors.black12,
              )),
            ),
            child: ListTile(
              leading: Text(
                '性别',
                style: TextStyle(fontSize: ScreenUtil().setSp(36)),
              ),
              title: Text('    $sex'),
              contentPadding: EdgeInsets.only(left: 20, right: 10),
              trailing: Icon(Icons.chevron_right),
              onTap: () async {
                // showDialog(context: ());
                print("点击了我的地址");
                var updateSex = await showDialog<String>(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text("请选择性别"),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, '男');
                            },
                            child: Text('男'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, '女');
                            },
                            child: Text('女'),
                          )
                        ],
                      );
                    });
                if (updateSex != sex) {
                  var res = await Provide.value<UserProvide>(context)
                      .updateUserInfo(updateSex);
                  var tokenErr = Provide.value<UserProvide>(context).tokenErr;
                  if (tokenErr) {
                    showToast("token过期,请重新登录");
                    Application.router.navigateTo(context, '/login');
                    Navigator.of(context).pop();
                    return;
                  }
                  if (res) {
                    showToast("修改成功");
                  } else {
                    showToast("修改失败");
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
