import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'home_page/home_page.dart';
import 'category_page/category_page.dart';
import 'cart_page/cart_page.dart';
import 'member_page/member_page.dart';
import '../provide/currentIndex.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    ),
  ];

  // 页面数组
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, width: 750, height: 1334);
    ScreenUtil.init(context, width: 750, height: 1080);
    print(ScreenUtil.screenHeight);
    return Provide<CurrentIndexProvide>(builder: (context, child, val) {
      int currentIndex =
          Provide.value<CurrentIndexProvide>(context).currentIndex;
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomTabs,
          // fixed和shifting要3个以上才有效果
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            Provide.value<CurrentIndexProvide>(context).changeIndex(index);
          },
        ),
        // 使用indexedStack保持页面状态
        body: IndexedStack(
          index: currentIndex,
          children: tabBodies,
        ),
      );
    });
  }
}
