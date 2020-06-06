import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';

// 楼层商品列表
class Floor extends StatelessWidget {
  final List floorGoodsList;
  final String floorTitle;
  Floor({this.floorGoodsList, this.floorTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _title(context),
          _firstRow(context),
          _otherFloorGoods(context)
        ],
      ),
    );
  }

  // Widget _title() {
  //   return Container(
  //     alignment: Alignment.center,
  //     child: Text(floorName),
  //   );
  // }

  // 标题图片
  Widget _title(context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        floorTitle,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  Widget _firstRow(BuildContext context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, floorGoodsList[1]),
            _goodsItem(context, floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherFloorGoods(BuildContext context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[3]),
        _goodsItem(context, floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context, goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
          onTap: () {
            Application.router
                .navigateTo(context, "/detail?id=${goods.goodsId}");
          },
          child: Image.network(goods.image)),
    );
  }
}
