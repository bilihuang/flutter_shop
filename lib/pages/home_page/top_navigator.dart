import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/currentIndex.dart';
import '../../provide/category.dart';

// 顶部导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({this.navigatorList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(290),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        // 每行5个
        crossAxisCount: 4,
        padding: EdgeInsets.all(5),
        // 禁用滑动，防止出现上下拉阴影
        physics: NeverScrollableScrollPhysics(),
        children: navigatorList
            .map((item) => _gridViewItemUI(context, item))
            .toList(),
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, item) {
    // 水波纹组件
    return InkWell(
      onTap: () async {
        await Provide.value<CategoryProvide>(context)
            .navigateToCategory(int.parse(item.categoryId) - 1);
        Provide.value<CurrentIndexProvide>(context).changeIndex(1);
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item.categoryImage,
            width: ScreenUtil().setWidth(95),
          ),
          Text(item.categoryName)
        ],
      ),
    );
  }
}
