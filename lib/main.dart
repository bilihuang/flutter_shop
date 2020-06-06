import 'package:flutter/material.dart';
import './provide/address.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './provide/index.dart';
import './provide/category.dart';
import './provide/goods_datails.dart';
import './provide/cart.dart';
import './provide/currentIndex.dart';
import './provide/search.dart';
import './provide/user.dart';
import './provide/user_order.dart';

void main() {
  // provide顶层依赖
  var providers = Providers();
  var index = IndexProvide();
  var category = CategoryProvide();
  var detailsProvide = GoodsDetailsProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var searchProvide = SearchProvide();
  var userProvide = UserProvide();
  var addressProvide = AddressProvide();
  var userOrderProvide = UserOrderProvide();

  providers
    ..provide(Provider<IndexProvide>.value(index))
    ..provide(Provider<CategoryProvide>.value(category))
    ..provide(Provider<GoodsDetailsProvide>.value(detailsProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<SearchProvide>.value(searchProvide))
    ..provide(Provider<UserProvide>.value(userProvide))
    ..provide(Provider<AddressProvide>.value(addressProvide))
    ..provide(Provider<UserOrderProvide>.value(userOrderProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 路由初始化
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
          title: '百姓生活',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(
            primarySwatch: Colors.pink,
            // brightness: Brightness.dark,
          ), // 主题颜色
          home: IndexPage()),
    );
  }
}
