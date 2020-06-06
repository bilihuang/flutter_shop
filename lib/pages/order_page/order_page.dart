import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './order_item.dart';
import 'package:provide/provide.dart';
import './order_address.dart';
import './order_price.dart';
import '../../provide/cart.dart';
import '../../provide/user.dart';
import '../../provide/address.dart';
import '../../utils/confirm_dialog.dart';
import '../../utils/toast.dart';
import '../../routers/application.dart';
import '../../provide/user_order.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单确认'),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              OrderAddress(),
              _orderDetail(context),
              _price(context)
            ],
          ),
          Positioned(bottom: 0, child: _bottom(context))
        ],
      ),
    );
  }

  Widget _bottom(context) {
    return Provide<CartProvide>(builder: (context, child, val) {
      double price = Provide.value<CartProvide>(context).totalPrice;
      return Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    '合计：',
                    style: TextStyle(fontSize: ScreenUtil().setSp(34)),
                  ),
                  Text(
                    '￥${price}0',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ScreenUtil().setSp(34)),
                  )
                ],
              ),
            ),
            Container(
              child: InkWell(
                onTap: () async {
                  var token =
                      Provide.value<UserProvide>(context).userInfoJson['token'];
                  var addressId =
                      Provide.value<AddressProvide>(context).curAddress.id;
                  String orderId = await Provide.value<CartProvide>(context)
                      .submitOrder(token, addressId);
                  bool submitSuc =
                      Provide.value<CartProvide>(context).submitSuc;
                  if (submitSuc) {
                    bool pay = await showConfirmDialog(context, "确认付款吗？");
                    if (pay) {
                      await Provide.value<UserOrderProvide>(context)
                          .updateOrderStatus(token, orderId, 2);
                      var res =
                          Provide.value<UserOrderProvide>(context).updateSuc;
                      var tokenErr =
                          Provide.value<UserOrderProvide>(context).tokenErr;
                      if (tokenErr) {
                        showToast("token过期,请重新登录");
                        Navigator.of(context).pop();
                        Application.router.navigateTo(context, '/login');
                        return;
                      }
                      if (res) {
                        showToast("付款成功");
                        Navigator.of(context).pop();
                      } else {
                        showToast("付款失败");
                      }
                    } else {
                      showToast("付款失败");
                      Navigator.of(context).pop();
                      Application.router.navigateTo(context, '/userorder');
                    }
                  } else {
                    showToast("创建订单失败");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text('去付款', style: TextStyle(color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _orderDetail(context) {
    List cartGoodsList = Provide.value<CartProvide>(context).getCheckedGoods();
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: cartGoodsList.map((item) => OrderItem(item)).toList(),
        // itemCount: cartGoodsList.length,
        // itemBuilder: (context, index) {
        //   return OrderItem(cartGoodsList[index]);
        // }
      ),
    );
  }

  Widget _price(context) {
    double price = Provide.value<CartProvide>(context).totalPrice;
    return OrderPrice(price);
  }
}
