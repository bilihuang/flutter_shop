import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_datails.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailsProvide>(builder: (context, child, val) {
      var isDetails = Provide.value<GoodsDetailsProvide>(context).isDetails;
      var isComments = Provide.value<GoodsDetailsProvide>(context).isComments;
      return Container(
        margin: EdgeInsets.only(top: 15),
        child: Row(
          children: <Widget>[
            _tabBarDetails(context, isDetails),
            _tabBarComments(context, isComments)
          ],
        ),
      );
    });
  }

  Widget _tabBarDetails(BuildContext context, bool isDetails) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailsProvide>(context).changeTabBar('details');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: isDetails
                        ? Theme.of(context).primaryColor
                        : Colors.black12))),
        child: Text(
          '详情',
          style: TextStyle(
              color: isDetails ? Theme.of(context).primaryColor : Colors.black),
        ),
      ),
    );
  }

  Widget _tabBarComments(BuildContext context, bool isComments) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailsProvide>(context).changeTabBar('comments');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: isComments
                        ? Theme.of(context).primaryColor
                        : Colors.black12))),
        child: Text(
          '评论',
          style: TextStyle(
              color:
                  isComments ? Theme.of(context).primaryColor : Colors.black),
        ),
      ),
    );
  }
}
