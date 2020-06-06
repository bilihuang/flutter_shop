import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../routers/application.dart';
import '../../provide/user.dart';

class MemberOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<UserProvide>(builder: (context, child, val) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            _userInfo(context),
            _address(context),
            _logout(context)
          ],
        ),
      );
    });
  }

  // 个人信息
  Widget _userInfo(context) {
    bool isLogin = Provide.value<UserProvide>(context).isLogin;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(
          width: 1,
          color: Colors.black12,
        )),
      ),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('个人信息'),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          if (isLogin) {
            Application.router.navigateTo(context, "/user");
          } else {
            Application.router.navigateTo(context, "/login");
          }
        },
      ),
    );
  }

  Widget _address(context) {
    bool isLogin = Provide.value<UserProvide>(context).isLogin;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(
          width: 1,
          color: Colors.black12,
        )),
      ),
      child: ListTile(
        leading: Icon(Icons.location_on),
        title: Text('地址管理'),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          if (isLogin) {
            Application.router.navigateTo(context, "/address?choose=false");
          } else {
            Application.router.navigateTo(context, "/login");
          }
        },
      ),
    );
  }

  Widget _logout(context) {
    bool isLogin = Provide.value<UserProvide>(context).isLogin;
    if (isLogin) {
      return Container(
          height: ScreenUtil().setHeight(100),
          width: ScreenUtil().setWidth(750),
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.black12,
            ),
          ),
          child: InkWell(
              child: Text(
                '退出登录',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ScreenUtil().setSp(36)),
              ),
              onTap: () {
                Provide.value<UserProvide>(context).logout();
              }));
    } else {
      return Container();
    }
  }
}
