import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../model/cartInfo.dart';
import '../../provide/cart.dart';
import './cart_count.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context),
          _cartIamge(),
          _cartGoodsName(),
          _cartGoodsPrice(context)
        ],
      ),
    );
  }

  // 选中按钮
  Widget _cartCheckBt(context) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
      ),
    );
  }

  // 商品图片
  Widget _cartIamge() {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.image),
    );
  }

  // 商品名称
  Widget _cartGoodsName() {
    return Container(
      width: ScreenUtil().setWidth(350),
      // height: ScreenUtil().setWidth(180),
      padding: EdgeInsets.all(10),
      // alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(item.goodsName), CartCount(item)],
      ),
    );
  }

  // 商品价格
  Widget _cartGoodsPrice(context) {
    return Container(
      width: ScreenUtil().setWidth(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
                onTap: () {
                  Provide.value<CartProvide>(context)
                      .deleteOneGoods(item.goodsId);
                },
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.black26,
                  size: 30,
                )),
          )
        ],
      ),
    );
  }
}
