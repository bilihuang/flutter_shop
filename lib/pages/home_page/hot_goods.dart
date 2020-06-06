import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';

class HotGoods extends StatelessWidget {
  final List hotGoodsList;
  HotGoods({this.hotGoodsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_hotTitle(context), _wrap(context)],
      ),
    );
  }

  Widget _hotTitle(context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: Text(
        '火爆专区',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  Widget _wrap(context) {
    return Wrap(
      spacing: 2,
      children: _wrapList(context),
    );
  }

  List<Widget> _wrapList(context) {
    return hotGoodsList.map((val) {
      return InkWell(
        onTap: () {
          Application.router.navigateTo(context, "/detail?id=${val.goodsId}");
        },
        child: Container(
          width: ScreenUtil().setWidth(372),
          color: Colors.white,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 3),
          child: Column(
            children: <Widget>[
              Image.network(val.goodsImage, width: ScreenUtil().setWidth(370)),
              Text(val.goodsName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ScreenUtil().setSp(26))),
              Row(
                children: <Widget>[
                  Text(
                    '￥${val.goodsPrice}',
                    style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }).toList();
  }
}
