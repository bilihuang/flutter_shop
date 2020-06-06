import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/goods_datails.dart';
import '../service/service_method.dart';
import '../config/config.dart';

class GoodsDetailsProvide with ChangeNotifier {
  GoodsInfo goodsInfo;

  // TabBar切换状态布尔值
  bool isDetails = true;
  bool isComments = false;

  // TabBar的切换方法
  changeTabBar(String changeState) {
    if (changeState == 'details') {
      isDetails = true;
      isComments = false;
    } else {
      isDetails = false;
      isComments = true;
    }
    notifyListeners();
  }

  // 从后台获取商品数据
  getGoodsDetail(String id) async {
    var data = {'goodsId': id};
    await request('getGoodDetailById', GET, data: data).then((val) {
      goodsInfo = GoodsDetailsModel.fromJson(val).data.goodsInfo;
      notifyListeners();
    });
  }
  // getGoodsDetail(String id) {
  //   var data = {'goodId': id};
  //   request('getGoodDetailById', data: data).then((val) {
  //     var responseData = jsonDecode(val.toString());
  //     print(responseData);
  //     goodsDetail = GoodsDetailsModel.fromJson(responseData);
  //     notifyListeners();
  //   });
  // }

  getGood() {
    var data = {'goodId': '1ef4793ebcf04140b37e8226f01a5bb2'};
    request('getGoodDetailByI', POST, data: data).then((val) {
      var responseData = json.decode(val.toString());
      print('响应数据$responseData');
    });
  }
}
