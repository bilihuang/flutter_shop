import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../routers/application.dart';
import '../../provide/category.dart';
import '../../model/category_goods_list.dart';

class CategoryGoodsList extends StatelessWidget {
  final ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvide>(builder: (context, child, val) {
      try {
        if (Provide.value<CategoryProvide>(context).page == 1) {
          // 列表位置回到最顶部
          scrollController.jumpTo(0.0);
        }
      } catch (e) {
        print('第一次进入页面初始化:$e');
      }
      List goodsList = Provide.value<CategoryProvide>(context).goodsList;
      if (goodsList.length > 0) {
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            // height: ScreenUtil().setHeight(1000),
            child: ListView.builder(
              controller: scrollController,
              itemCount: goodsList.length,
              itemBuilder: (context, index) {
                return _listItemWidget(context, goodsList[index]);
              },
            ),
          ),
        );
      } else {
        return Center(
          child: Text('暂无数据'),
        );
      }
    });
  }

  // 商品项
  Widget _listItemWidget(context, CategoryGoodsListData item) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "/detail?id=${item.goodsId}");
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12),
            )),
        child: Row(
          children: <Widget>[
            _goodsImage(item.goodsImage),
            Column(
              children: <Widget>[
                _goodsName(item.goodsName),
                _goodsPrice(context, item.goodsPrice),
              ],
            )
          ],
        ),
      ),
    );
  }

  // 商品图片
  Widget _goodsImage(String image) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(image),
    );
  }

  // 商品名称
  Widget _goodsName(String goodsName) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(370),
      child: Text(
        goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  // 商品价格
  Widget _goodsPrice(context, double price) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      child: Text(
        '价格：￥$price',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }
}
