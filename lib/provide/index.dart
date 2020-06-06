import 'package:flutter/material.dart';
import '../model/index.dart';
import '../service/service_method.dart';
import '../config/config.dart';

class IndexProvide with ChangeNotifier {
  IndexModel indexData;
  List<Swipers> swipers;
  FloorName floorName;
  List<FloorOne> floorOne;
  List<FloorTwo> floorTwo;
  List<FloorThree> floorThree;
  List<Category> category;
  List<Recommend> recommend;
  List<HotGoods> hotGoods;

  // 从后台获取商品数据
  getIndexData() async {
    await request('getIndexData', GET).then((val) {
      indexData = IndexModel.fromJson(val);
      swipers = indexData.data.swipers;
      floorName = indexData.data.floorName;
      floorOne = indexData.data.floorOne;
      floorTwo = indexData.data.floorTwo;
      floorThree = indexData.data.floorThree;
      category = indexData.data.category;
      recommend = indexData.data.recommend;
      hotGoods = indexData.data.hotGoods;
      notifyListeners();
    });
  }
}
