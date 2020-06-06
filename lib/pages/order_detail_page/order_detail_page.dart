import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/user_order.dart';
import '../../model/order.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderId;
  OrderDetailPage(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
      ),
      body: Provide<UserOrderProvide>(builder: (context, child, val) {
        OrderData orderData = Provide.value<UserOrderProvide>(context)
            .getOrderDetailsByOrderId(orderId);
        return Container(
          width: ScreenUtil().setWidth(750),
          child: Column(
            children: <Widget>[
              _addressArea(context, orderData.addressInfo),
              _orderDetail(context, orderData.orderDetails),
              _price(context, orderData.orderPrice),
              _orderOtherInfo(context, orderData.orderId, orderData.createTime,
                  orderData.updateTime)
            ],
          ),
        );
      }),
    );
  }

  // Future getOrderDetailByOrderId(context) async{
  //   return
  // }

  Widget _addressArea(context, AddressInfo addressInfo) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: ScreenUtil().setWidth(750),
      decoration:
          BoxDecoration(border: Border.all(width: 2, color: Colors.black26)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              '收货人：${addressInfo.recipent}',
              style: TextStyle(fontSize: ScreenUtil().setSp(32)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              '电话：${addressInfo.phone}',
              style: TextStyle(fontSize: ScreenUtil().setSp(32)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              '地址：${addressInfo.address}',
              style: TextStyle(fontSize: ScreenUtil().setSp(32)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderDetail(context, List<OrderDetails> orderDetailList) {
    List<OrderDetails> orderDetails = orderDetailList;
    return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: orderDetails.map((i) {
            return _orderDetailItem(i);
          }).toList(),
        ));
  }

  Widget _orderDetailItem(OrderDetails detailItem) {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.white,
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
                  Text(
                    '￥${detailItem.goodsPrice}0 x ${detailItem.goodsCount}件',
                    style: TextStyle(color: Colors.black45),
                  )
                ],
              )),
          Container(
            child: Text('￥${detailItem.goodsPrice * detailItem.goodsCount}0'),
          )
        ],
      ),
    );
  }

  Widget _price(context, price) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '商品总额',
                    style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                  ),
                  Text(
                    '￥${price}0',
                    style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '运费',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: Colors.black45),
                  ),
                  Text(
                    '￥0.00',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: Colors.black45),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '实付款（含运费）',
                    style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                  ),
                  Text(
                    '￥${price}0',
                    style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _orderOtherInfo(context, id, createTime, updateTime) {
    var newCreateTime = DateTime.parse(createTime).toString().substring(0, 19);
    var newUpdateTime = DateTime.parse(updateTime).toString().substring(0, 19);
    return Container(
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(2.5),
            child: Text(
              '订单编号：$id',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30), color: Colors.black45),
            ),
          ),
          Container(
            margin: EdgeInsets.all(2.5),
            child: Text(
              '创建时间：$newCreateTime',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30), color: Colors.black45),
            ),
          ),
          Container(
            margin: EdgeInsets.all(2.5),
            child: Text(
              '更新时间：$newUpdateTime',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30), color: Colors.black45),
            ),
          )
        ],
      ),
    );
  }
}
