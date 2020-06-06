import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../routers/application.dart';

// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList; // 轮播数据数组
  SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    // 设置屏幕适配尺寸
    return Container(
      // 所有尺寸均用screenUtil
      height: ScreenUtil().setHeight(280),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Image.network(
              '${swiperDataList[index].image}',
              fit: BoxFit.fill,
            ),
            onTap: () {
              Application.router.navigateTo(
                  context, "/detail?id=${swiperDataList[index].goodsId}");
            },
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
