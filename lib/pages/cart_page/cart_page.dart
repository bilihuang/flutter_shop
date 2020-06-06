import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/currentIndex.dart';
import '../../provide/cart.dart';
import 'cart_item.dart';
import 'cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('购物车')),
      body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Provide<CartProvide>(builder: (context, child, val) {
                List cartList = Provide.value<CartProvide>(context).cartList;
                if (cartList.length > 0) {
                  return Stack(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 65),
                      child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          return CartItem(cartList[index]);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: CartBottom(),
                    )
                  ]);
                } else {
                  return Container(
                    height: ScreenUtil().setHeight(1200),
                    width: ScreenUtil().setWidth(750),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '购物车还空着，赶紧去逛逛吧',
                          style: TextStyle(color: Colors.black54),
                        ),
                        RaisedButton(
                            child: Text(
                              "随便逛逛",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Provide.value<CurrentIndexProvide>(context)
                                  .changeIndex(0);
                            })
                      ],
                    ),
                  );
                }
              });
            } else {
              return Text('正在加载……');
            }
          }),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
