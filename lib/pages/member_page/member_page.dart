import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/index.dart';
import '../../provide/user.dart';
import './member_top.dart';
import './member_order.dart';
import './member_option.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('会员中心'),
        ),
        body: FutureBuilder(
            future: _getUserInfo(context),
            builder: (context, snapshot) {
              return ListView(
                children: <Widget>[MemberTop(), MemberOrder(), MemberOption()],
              );
            }));
  }

  // 初始化获取用户信息
  Future _getUserInfo(context) async {
    return await Provide.value<UserProvide>(context).initUserInfo();
  }
}
