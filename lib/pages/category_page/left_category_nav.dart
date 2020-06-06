import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/category.dart';
import '../../model/category.dart';

class LeftCategoryNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvide>(builder: (context, child, val) {
      List categoryList = Provide.value<CategoryProvide>(context).categoryList;
      int curIndex = Provide.value<CategoryProvide>(context).categoryIndex;
      return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _leftInkWell(
                  context, categoryList[index], index, curIndex);
            },
            itemCount: categoryList.length),
      );
    });
  }

  Widget _leftInkWell(context, CategoryData item, int index, int curIndex) {
    bool isClick = false;
    isClick = (index == curIndex) ? true : false;
    return InkWell(
      onTap: () async {
        // 子类数组
        var subcategoryList = item.subcategory;
        var categoryId = item.categoryId;

        await Provide.value<CategoryProvide>(context)
            .getSubcategory(subcategoryList, categoryId, index);
        await Provide.value<CategoryProvide>(context).jumpTop();
        // Provide.value<CategoryProvide>(context)
        //     .getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(90),
        // padding: EdgeInsets.only(left: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          item.categoryName,
          // style: TextStyle(fontSize: ScreenUtil().setSp(16)),
        ),
      ),
    );
  }
}
