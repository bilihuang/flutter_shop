import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/cart.dart';
import '../../model/cartInfo.dart';

class OrderItem extends StatelessWidget {
  final CartInfoModel item;
  OrderItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(130),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(100),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12)),
            child: Image.network(item.image),
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 15),
              width: ScreenUtil().setWidth(420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.goodsName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
          Container(
            height: ScreenUtil().setHeight(80),
            margin: EdgeInsets.only(left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('￥${item.price}0'),
                Text('x ${item.count}')
              ],
            ),
          )
        ],
      ),
    );
  }
}
