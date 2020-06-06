import 'package:flutter/material.dart';
import './order_empty.dart';
import 'package:provide/provide.dart';
import '../../provide/user_order.dart';
import '../../provide/user.dart';
import './order_item.dart';

class UserOrderPage extends StatefulWidget {
  @override
  _UserOrderPageState createState() => _UserOrderPageState();
}

class _UserOrderPageState extends State<UserOrderPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["全部", "待付款", "待发货", "待收货"];
  int curIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          curIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<UserOrderProvide>(builder: (context, child, val) {
      var token = Provide.value<UserProvide>(context).userInfoJson['token'];
      return Scaffold(
          appBar: AppBar(
            title: Text('订单中心'),
            bottom: TabBar(
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList(),
              indicatorColor: Colors.white,
              onTap: (index) async {
                await Provide.value<UserOrderProvide>(context)
                    .getUserOrder(token, index);
              },
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: new NeverScrollableScrollPhysics(), // 禁用滑动
            children: List.generate(4, (index) {
              var orderList =
                  Provide.value<UserOrderProvide>(context).orderListMap[index];
              if (orderList.length > 0) {
                return Container(
                    child: ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return OrderItem(orderList[index]);
                        }));
              } else {
                return OrderEmpty();
              }
            }),
          ));
    });
  }
}
