import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';
import '../../provide/search.dart';
import '../../model/search.dart';

class ResultsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<SearchProvide>(builder: (context, child, val) {
      List searchResultsList =
          Provide.value<SearchProvide>(context).searchDataList;
      if (searchResultsList.length != 0) {
        return Container(
          width: ScreenUtil().setWidth(750),
          // height: ScreenUtil().setHeight(1000),
          child: ListView.builder(
            // controller: scrollController,
            itemCount: searchResultsList.length,
            itemBuilder: (context, index) {
              return _searchResultsItem(context, searchResultsList[index]);
            },
          ),
        );
      } else {
        return Container();
      }
    });
  }

  // 搜索结果商品项
  _searchResultsItem(context, SearchData item) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "/detail?id=${item.goodsId}");
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        )),
        child: Row(
          children: <Widget>[
            _goodsImage(item.goodsImage),
            Column(
              children: <Widget>[
                _goodsName(context, item.goodsName),
                _goodsPrice(item.goodsPrice),
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
      margin: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(200),
      child: Image.network(image),
    );
  }

  // 商品名称
  Widget _goodsName(context, String goodsName) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(470),
      child: Text(
        goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(30),
            color: Theme.of(context).primaryColor),
      ),
    );
  }

  // 商品价格
  Widget _goodsPrice(double price) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 5),
      width: ScreenUtil().setWidth(470),
      child: Text(
        '价格：￥$price',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }
}
