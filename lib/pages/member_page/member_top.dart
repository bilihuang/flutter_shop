import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/user.dart';
import '../../routers/application.dart';

class MemberTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<UserProvide>(builder: (context, child, val) {
      bool isLogin = Provide.value<UserProvide>(context).isLogin;
      return Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(370),
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Colors.orange[200]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _userInfo(context, isLogin),
      );
    });
  }

  // 判断是否已登录，返回对应内容
  Widget _userInfo(context, isLogin) {
    if (isLogin) {
      String userName =
          Provide.value<UserProvide>(context).userInfoJson["userName"];
      String avatar =
          Provide.value<UserProvide>(context).userInfoJson["avatar"];
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Colors.white),
            ),
            // width: ScreenUtil().setWidth(100),
            // height: ScreenUtil().setHeight(100),
            // decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //       image: NetworkImage(
            //           "https://huangdongyang.cn/images/avatar.jpg"),
            //       fit: BoxFit.contain,
            //     )),
            // child: ClipOval(
            //   child: Image.network(
            //     "https://huangdongyang.cn/images/avatar.jpg",
            //     width: ScreenUtil().setWidth(115),
            //     height: ScreenUtil().setHeight(100),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            child: CircleAvatar(
              radius: ScreenUtil().setWidth(100),
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(avatar),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              userName,
              style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenUtil().setSp(40),
              ),
            ),
          )
        ],
      );
    } else {
      return Container(
        width: ScreenUtil().setWidth(200),
        height: ScreenUtil().setHeight(70),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
            child: Text(
              '点击登录',
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(36)),
            ),
            onTap: () {
              Application.router.navigateTo(context, '/login');
            }),
      );
    }
  }
}
