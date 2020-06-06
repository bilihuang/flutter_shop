import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/currentIndex.dart';

class OrderEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(1200),
      width: ScreenUtil().setWidth(750),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '您还没有此类订单，赶紧去逛逛吧',
            style: TextStyle(color: Colors.black54),
          ),
          RaisedButton(
              child: Text(
                "随便逛逛",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Provide.value<CurrentIndexProvide>(context).changeIndex(0);
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}
