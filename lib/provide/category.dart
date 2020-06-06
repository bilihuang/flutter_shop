import 'package:flutter/material.dart';
import '../config/config.dart';
import '../model/category.dart';
import '../model/category_goods_list.dart';
import '../service/service_method.dart';

class CategoryProvide with ChangeNotifier {
  List<CategoryData> categoryList = [];
  List<Subcategory> subcategoryList = [];
  List<CategoryGoodsListData> goodsList = [];
  int categoryIndex = 0; // 一级分类当前点击索引
  int subcategoryIndex = 0; // 子类高亮索引
  String categoryId = '0'; // 大类Id，默认为1
  String subcategoryId = ''; // 小类Id
  bool isJump = false; // 是否跳到顶部
  int page = 1; // 列表页数
  String noMoreText = '已经到底了'; // 没有数据时下拉加载的提示文字

  // 获取一级二级分类信息
  getAllCategoryInfo() {
    request("getAllCategoryInfo", GET).then((val) {
      categoryList = CategoryModel.fromJson(val).data;
      // 获取后初始化为第一项
      getSubcategory(
          categoryList[0].subcategory, categoryList[0].categoryId, 0);
    });
  }

  // 大类切换，获取子类
  getSubcategory(List<Subcategory> list, String id, int curIndex) async {
    // 每次点击将该索引清零
    subcategoryIndex = 0;
    categoryId = id;
    categoryIndex = curIndex;
    page = 1;
    noMoreText = '已经到底了';
    // 在二级分类中添加全部项
    Subcategory all = Subcategory();
    all.categoryId = id;
    all.subcategoryId = '0';
    all.subcategoryName = '全部';
    subcategoryList = [all];
    subcategoryList.addAll(list);

    getGoodsList(categoryId: id);
  }

  // 获取商品列表数据
  getGoodsList({String categoryId, String subcategoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '0' : categoryId,
      'subcategoryId': subcategoryId == null ? '0' : subcategoryId
    };

    await request("getCategoryGoods", GET, data: data).then((val) {
      // print('分类商品$val');
      goodsList = CategoryGoodsListModel.fromJson(val).data;
      notifyListeners();
    });
  }

  // 改变子类索引
  changesubcategoryIndex(index, String id) async {
    subcategoryIndex = index;
    subcategoryId = id;
    page = 1;
    noMoreText = '已经到底了';
    getGoodsList(categoryId: categoryId, subcategoryId: id);
  }

  // 跳转到对应分类
  navigateToCategory(index) async {
    categoryIndex = index;
    await getSubcategory(categoryList[index].subcategory,
        categoryList[index].categoryId, categoryIndex);
    notifyListeners();
  }

  // 商品列表下一页的方法
  nextPage() {
    page++;
  }

  // 下拉加载无商品时提示文字
  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }

  jumpTop() {
    isJump = true;
    // notifyListeners();
  }
}
