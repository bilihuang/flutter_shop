import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../provide/goods_datails.dart';

class DetailsImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetailsImage =
        Provide.value<GoodsDetailsProvide>(context).goodsInfo.goodsDetail;
    return Provide<GoodsDetailsProvide>(builder: (context, child, val) {
      var isDetails = Provide.value<GoodsDetailsProvide>(context).isDetails;
      if (isDetails) {
        return Container(
          margin: EdgeInsets.only(bottom: 45),
          child: Html(data: goodsDetailsImage),
        );
      } else {
        return Container(
          width: ScreenUtil().setWidth(750),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text('暂无评论'),
        );
      }
    });
  }
}
