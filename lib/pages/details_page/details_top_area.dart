import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/goods_datails.dart';

// 详情页首部
class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailsProvide>(builder: (context, child, val) {
      var goodsInfo = Provide.value<GoodsDetailsProvide>(context).goodsInfo;
      if (goodsInfo != null) {
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _goodsImage(goodsInfo.goodsImage),
              _goodsName(goodsInfo.goodsName),
              _goodsPrice(context, goodsInfo.goodsPrice)
            ],
          ),
        );
      } else {
        return Text('正在加载中');
      }
    });
  }

  // 商品图片
  Widget _goodsImage(url) {
    return Container(
      width: ScreenUtil().setWidth(740),
      child: Image.network(
        url,
        width: ScreenUtil().setWidth(740),
      ),
    );
  }

  // 商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      child: Text(name, style: TextStyle(fontSize: ScreenUtil().setSp(32))),
    );
  }

  // 商品编号
  Widget _goodsNumber(number) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号：$number',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  // 商品价格
  Widget _goodsPrice(context, price) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      child: Text(
        '￥$price',
        style: TextStyle(
            fontSize: ScreenUtil().setSp(34),
            color: Theme.of(context).primaryColor),
      ),
    );
  }
}
