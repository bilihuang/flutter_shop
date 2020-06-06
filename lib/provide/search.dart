import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/service_method.dart';
import '../model/search.dart';
import '../config/config.dart';

class SearchProvide with ChangeNotifier {
  List<SearchData> searchDataList = [];
  List<String> searchWordList = [];

  // 初始化
  initsearchWord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempString = prefs.getString("searchWordList");
    this.searchWordList =
        tempString == null ? [] : (jsonDecode(tempString) as List).cast();
    notifyListeners();
  }

  searchGoods(String searchWord) async {
    var data = {'searchWord': searchWord};
    await request("searchGoods", GET, data: data).then((val) {
      searchDataList = SearchModel.fromJson(val).data;
    });
    // 当历史记录有该搜索词时，把该搜索词放至数组首位
    if (searchWordList.any((item) => (item == searchWord))) {
      searchWordList.remove(searchWord);
    }

    searchWordList.insert(0, searchWord);
    if (searchWordList.length > 20) {
      searchWordList.removeLast();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('searchWordList', jsonEncode(searchWordList).toString());
    notifyListeners();
  }
}
