import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/user.dart';
import '../../provide/address.dart';
import '../../utils/toast.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Provide<CartProvide>(
        builder: (context, child, val) {
          return Row(
            children: <Widget>[
              _checkAllBtn(context),
              _cartPriceArea(context),
              _settleButton(context)
            ],
          );
        },
      ),
    );
  }

  // 全选按钮
  Widget _checkAllBtn(context) {
    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
              value: isAllCheck,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (bool val) {
                Provide.value<CartProvide>(context).changeCheckAllBtn(val);
              }),
          Text(
            '全选',
            style: TextStyle(fontSize: ScreenUtil().setSp(32)),
          )
        ],
      ),
    );
  }

  // 合计价格区域
  Widget _cartPriceArea(context) {
    double totalPrice = Provide.value<CartProvide>(context).totalPrice;
    return Container(
      width: ScreenUtil().setWidth(420),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil().setWidth(250),
            child: Text(
              '合计：',
              style: TextStyle(fontSize: ScreenUtil().setSp(36)),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: ScreenUtil().setWidth(170),
            child: Text(
              '￥$totalPrice',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36),
                  color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }

  // 结算按钮
  Widget _settleButton(context) {
    int totalGoodsCount = Provide.value<CartProvide>(context).totalGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      height: ScreenUtil().setHeight(60),
      padding: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () async {
          var isLogin = Provide.value<UserProvide>(context).isLogin;
          if (isLogin) {
            var token =
                Provide.value<UserProvide>(context).userInfoJson['token'];
            await Provide.value<AddressProvide>(context)
                .getDefaultAddress(token);
            Application.router.navigateTo(context, '/order');
          } else {
            showToast('请先登录');
            Application.router.navigateTo(context, '/login');
          }
        },
        child: Container(
          // padding: EdgeInsets.fromLTRB(5, 9, 5, 9),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            '结算($totalGoodsCount)',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
