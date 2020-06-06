import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/utils/toast.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/order.dart';
import '../../provide/user_order.dart';
import '../../provide/user.dart';
import '../../routers/application.dart';
import '../../utils/confirm_dialog.dart';

class OrderItem extends StatelessWidget {
  final OrderData item;
  // final int index;
  // final int curIndex;
  OrderItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                _orderTitle(context),
                _orderDetail(context),
                _price(),
              ],
            ),
            onTap: () {
              Application.router
                  .navigateTo(context, '/orderdetail?orderId=${item.orderId}');
            },
          ),
          _bottomButton(context)
        ],
      ),
    );
  }

  Widget _orderTitle(context) {
    String orderStatusString = Provide.value<UserOrderProvide>(context)
        .getOrderStatusString(item.orderStatus);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('订单号：${item.orderId}',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: ScreenUtil().setSp(30))),
          Text(
            orderStatusString,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: ScreenUtil().setSp(30)),
          )
        ],
      ),
    );
  }

  Widget _orderDetail(context) {
    List<OrderDetails> orderDetails = item.orderDetails;
    return Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black26))),
        child: Column(
          children: orderDetails.map((i) {
            return _orderDetailItem(i);
          }).toList(),
        ));
  }

  Widget _orderDetailItem(OrderDetails detailItem) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(100),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12)),
            child: Image.network(detailItem.goodsImage),
          ),
          Container(
              margin: EdgeInsets.only(left: 10),
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setWidth(440),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    detailItem.goodsName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('x ${detailItem.goodsCount}')
                ],
              )),
          Container(
            child: Text('￥${detailItem.goodsPrice}0'),
          )
        ],
      ),
    );
  }

  Widget _price() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Text(
        '合计金额：￥${item.orderPrice}0',
      ),
    );
  }

  Widget _bottomButton(context) {
    if (item.orderStatus == 1) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black26),
                  borderRadius: BorderRadius.circular(6)),
              child: InkWell(
                child: Text('取消订单'),
                onTap: () async {
                  bool cancel = await showConfirmDialog(context, "确认取消订单？");
                  if (cancel) {
                    var token = Provide.value<UserProvide>(context)
                        .userInfoJson['token'];
                    await Provide.value<UserOrderProvide>(context)
                        .updateOrderStatus(token, item.orderId, -1);
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
                      showToast("取消订单成功");
                      await Provide.value<UserOrderProvide>(context)
                          .getUserOrder(token, 1);
                    } else {
                      showToast("取消订单失败");
                    }
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6)),
              child: InkWell(
                child: Text(
                  '去付款',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  bool pay = await showConfirmDialog(context, "确认付款吗？");
                  if (pay) {
                    var token = Provide.value<UserProvide>(context)
                        .userInfoJson['token'];
                    await Provide.value<UserOrderProvide>(context)
                        .updateOrderStatus(token, item.orderId, 2);
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
                      await Provide.value<UserOrderProvide>(context)
                          .getUserOrder(token, 1);
                    } else {
                      showToast("付款失败");
                    }
                  }
                },
              ),
            )
          ],
        ),
      );
    } else if (item.orderStatus == 2) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black26),
                  borderRadius: BorderRadius.circular(6)),
              child: InkWell(
                child: Text('取消订单'),
                onTap: () async {
                  bool cancel = await showConfirmDialog(context, "确认取消订单？");
                  if (cancel) {
                    var token = Provide.value<UserProvide>(context)
                        .userInfoJson['token'];
                    await Provide.value<UserOrderProvide>(context)
                        .updateOrderStatus(token, item.orderId, -1);
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
                      showToast("取消订单成功");
                      await Provide.value<UserOrderProvide>(context)
                          .getUserOrder(token, 2);
                    } else {
                      showToast("取消订单失败");
                    }
                  }
                },
              ),
            ),
          ],
        ),
      );
    } else if (item.orderStatus == 3) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6)),
              child: InkWell(
                child: Text(
                  '确认收货',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  bool recieve = await showConfirmDialog(context, "确认收货吗？");
                  if (recieve) {
                    var token = Provide.value<UserProvide>(context)
                        .userInfoJson['token'];
                    await Provide.value<UserOrderProvide>(context)
                        .updateOrderStatus(token, item.orderId, 4);
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
                      showToast("确认收货成功");
                      await Provide.value<UserOrderProvide>(context)
                          .getUserOrder(token, 3);
                    } else {
                      showToast("确认收货失败");
                    }
                  }
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
