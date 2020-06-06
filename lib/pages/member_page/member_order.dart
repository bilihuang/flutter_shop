import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/user.dart';
import '../../routers/application.dart';
import '../../provide/user_order.dart';

class MemberOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[_title(context), _orderType()],
    ));
  }

  Widget _title(context) {
    bool isLogin = Provide.value<UserProvide>(context).isLogin;
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(
          width: 1,
          color: Colors.black12,
        )),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.chevron_right),
        onTap: () async {
          if (isLogin) {
            var token =
                Provide.value<UserProvide>(context).userInfoJson['token'];
            await Provide.value<UserOrderProvide>(context)
                .getUserOrder(token, 0);
            // await Provide.value<UserOrderProvide>(context)
            //     .getUserOrder(token, 1);
            // await Provide.value<UserOrderProvide>(context)
            //     .getUserOrder(token, 2);
            // await Provide.value<UserOrderProvide>(context)
            //     .getUserOrder(token, 3);
            Application.router.navigateTo(context, "/userorder");
          } else {
            Application.router.navigateTo(context, "/login");
          }
        },
      ),
    );
  }

  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(250),
            child: InkWell(
              onTap: () {
                print("点击了待付款");
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.payment,
                    size: 30,
                  ),
                  Text("待付款"),
                ],
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(250),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.query_builder,
                    size: 30,
                  ),
                  Text("待发货"),
                ],
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(250),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.directions_car,
                    size: 30,
                  ),
                  Text("待收货"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
