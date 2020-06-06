import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];
  List<CartInfoModel> orderGoodsList = [];
  double totalPrice = 0; // 被选中总价
  int totalGoodsCount = 0; // 被选中商品总数
  int cartGoodsCount = 0; // 当前购物车物品总数
  bool isAllCheck = true; // 全选布尔值
  bool tokenErr = false;
  bool submitSuc;

  save(goodsId, goodsName, count, price, image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : jsonDecode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false; // 是否已存在该商品
    int ival = 0;
    totalPrice = 0;
    totalGoodsCount = 0;
    cartGoodsCount = 0;
    tempList.forEach((item) {
      // 若已存在该商品则数量加一
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        totalPrice += double.parse(
            (cartList[ival].count * cartList[ival].price).toStringAsFixed(1));
        totalGoodsCount += cartList[ival].count;
      }
      cartGoodsCount += cartList[ival].count; // 购物车商品数量加一
      ival++;
    });

    // 不存在该商品则添加该商品
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'image': image,
        'isCheck': true
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
      // 处理浮点数问题
      totalPrice =
          double.parse((totalPrice + count * price).toStringAsFixed(1));
      totalGoodsCount += count;
      cartGoodsCount += count;
    }

    cartString = jsonEncode(tempList).toString(); // 转成字符串
    prefs.setString('cartInfo', cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cartInfo', "[]");
    cartList = [];
    totalPrice = 0; // 总价
    totalGoodsCount = 0; // 商品总数
    cartGoodsCount = 0;
    isAllCheck = false;
    print('清空完成');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    isAllCheck = true;
    if (cartString != "[]" && cartString != null) {
      List<Map> tempList = (jsonDecode(cartString) as List).cast();
      totalPrice = 0;
      totalGoodsCount = 0;
      cartGoodsCount = 0;
      tempList.forEach((item) {
        if (item['isCheck']) {
          // 精度问题，需要将数字保留小数
          totalPrice = double.parse(
              (totalPrice + item['count'] * item['price']).toStringAsFixed(1));
          totalGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        // 无论是否选中都要算进购物车物品总数
        cartGoodsCount += item['count'];
        cartList.add(CartInfoModel.fromJson(item));
      });
    } else {
      // 当无数据时初始化
      totalPrice = 0;
      totalGoodsCount = 0;
      cartGoodsCount = 0;
      isAllCheck = false;
    }
    notifyListeners();
  }

  // 选中状态改变
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    int tempIndex = 0; // 遍历临时索引
    int changeIndex; // 删除项索引
    tempList.forEach((item) {
      // dart不允许循环时修改项的属性
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList[changeIndex] = cartItem.toJson(); //把对象变成Map值
    cartString = json.encode(tempList).toString(); //变成字符串
    prefs.setString('cartInfo', cartString); //进行持久化
    await getCartInfo(); //重新读取列表
  }

  // 点击全选按钮操作
  changeCheckAllBtn(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    if (cartString != "[]" && cartString != null) {
      List<Map> tempList = (json.decode(cartString) as List).cast();
      List<Map> newList = [];
      tempList.forEach((item) {
        // dart不允许循环时修改数组项
        var newItem = item;
        newItem['isCheck'] = isCheck;
        newList.add(newItem);
      });

      cartString = jsonEncode(newList).toString();
      prefs.setString('cartInfo', cartString);
    }

    await getCartInfo();
  }

  // 删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (jsonDecode(cartString) as List).cast();
    int tempIndex = 0; // 遍历临时索引
    int delIndex; // 删除项索引
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      } else {
        tempIndex++;
      }
    });

    tempList.removeAt(delIndex); // 删除对应项

    cartString = jsonEncode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }

  // 商品数量加减
  addOrReduceAction(cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (jsonDecode(cartString) as List).cast();
    int tempIndex = 0; // 循环临时索引
    int changeIndex = 0; // 改变项索引
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = jsonEncode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 结算获取当前选中购物车项
  List<CartInfoModel> getCheckedGoods() {
    return cartList.where((item) => (item.isCheck == true)).toList();
  }

  // setOrderGoods(good){
  //   orderGoodsList=
  // }

  // 提交订单
  submitOrder(token, addressId) async {
    List goodsList = getCheckedGoods()
        .map((item) => ({"goodsId": item.goodsId, "goodsCount": item.count}))
        .toList();
    String orderId = '';
    var data = {
      "token": token,
      "orderInfo": {
        "addressId": addressId,
        "orderPrice": totalPrice,
        "orderDetailList": goodsList
      }
    };
    await request('createOrder', POST, data: data).then((val) {
      if (val['code'] == 0) {
        submitSuc = true;
        orderId = val['data'];
        goodsList.forEach((item) {
          deleteOneGoods(item['goodsId']);
        });
      } else if (val['code'] == -2) {
        tokenErr = true;
      } else {
        submitSuc = false;
      }
    });
    getCartInfo();
    return orderId;
  }
}
