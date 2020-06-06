import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/category.dart';
import '../../model/category.dart';

class RightSubcategoryNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvide>(builder: (context, child, childCategory) {
      List subcategoryList =
          Provide.value<CategoryProvide>(context).subcategoryList;
      return Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subcategoryList.length,
          itemBuilder: (context, index) {
            return _rightInkWell(context, subcategoryList[index], index);
          },
        ),
      );
    });
  }

  Widget _rightInkWell(context, Subcategory item, int index) {
    bool isClick = false;
    isClick = index == Provide.value<CategoryProvide>(context).subcategoryIndex
        ? true
        : false;
    return InkWell(
      onTap: () async {
        // 点击二级分类逻辑
        await Provide.value<CategoryProvide>(context)
            .changesubcategoryIndex(index, item.subcategoryId);
        await Provide.value<CategoryProvide>(context).jumpTop();
        // Provide.value<CategoryProvide>(context)
        //     .getGoodsList(subcategoryId: item.subcategoryId);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        child: Text(
          item.subcategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Theme.of(context).primaryColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
