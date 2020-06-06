import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/category.dart';
import './left_category_nav.dart';
import './right_subcategory_nav.dart';
import './category_goods_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('商品分类')),
        body: FutureBuilder(
            future: _getCategoryInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    child: Row(
                  children: <Widget>[
                    LeftCategoryNav(),
                    Column(
                      children: <Widget>[
                        RightSubcategoryNav(),
                        CategoryGoodsList()
                      ],
                    )
                  ],
                ));
              } else {
                return Center(
                  child: Text('正在加载中'),
                );
              }
            }));
  }

  Future _getCategoryInfo(BuildContext context) async {
    await Provide.value<CategoryProvide>(context).getAllCategoryInfo();
    return Provide.value<CategoryProvide>(context).categoryList;
  }
}
// class CategoryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('商品分类')),
//         body: FutureBuilder(
//             future: _getCategoryInfo(context),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Container(
//                     child: Row(
//                   children: <Widget>[
//                     LeftCategoryNav(),
//                     Column(
//                       children: <Widget>[
//                         RightSubcategoryNav(),
//                         CategoryGoodsList()
//                       ],
//                     )
//                   ],
//                 ));
//               } else {
//                 return Center(
//                   child: Text('正在加载中'),
//                 );
//               }
//             }));
//   }

//   Future _getCategoryInfo(BuildContext context) async {
//     await Provide.value<CategoryProvide>(context).getAllCategoryInfo();
//     // 默认为1
//     // await Provide.value<CategoryProvide>(context).getGoodsList(categoryId: "1");
//     return Provide.value<CategoryProvide>(context).categoryList;
//   }
// }
