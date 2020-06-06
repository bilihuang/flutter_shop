import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/goods_datails.dart';
import '../../provide/currentIndex.dart';
import '../../provide/user.dart';
import '../../provide/address.dart';
import '../../routers/application.dart';
import '../../utils/toast.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<GoodsDetailsProvide>(context).goodsInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.goodsPrice;
    var image = goodsInfo.goodsImage;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Provide<CartProvide>(
                builder: (context, child, val) {
                  int goodsCount =
                      Provide.value<CartProvide>(context).cartGoodsCount;
                  return Positioned(
                      top: 0,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$goodsCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(22),
                          ),
                        ),
                      ));
                },
              )
            ],
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, price, image);
            },
            child: Container(
              width: ScreenUtil().setWidth(640),
              height: ScreenUtil().setHeight(80),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(30)),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () async {
          //     var isLogin = Provide.value<UserProvide>(context).isLogin;
          //     if (isLogin) {
          //       var token =
          //           Provide.value<UserProvide>(context).userInfoJson['token'];
          //       await Provide.value<AddressProvide>(context)
          //           .getDefaultAddress(token);
          //       Application.router.navigateTo(context, '/order');
          //     } else {
          //       showToast('请先登录');
          //       Application.router.navigateTo(context, '/login');
          //     }
          //   },
          //   child: Container(
          //     width: ScreenUtil().setWidth(320),
          //     height: ScreenUtil().setHeight(80),
          //     alignment: Alignment.center,
          //     color: Colors.red,
          //     child: Text(
          //       '立即购买',
          //       style: TextStyle(
          //           color: Colors.white, fontSize: ScreenUtil().setSp(30)),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
