import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class OrderPrice extends StatelessWidget {
  final double price;
  OrderPrice(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
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
              padding: EdgeInsets.all(15),
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
              padding: EdgeInsets.all(15),
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
}
