import 'package:flutter/material.dart';
import '../config/config.dart';
import '../service/service_method.dart';
import '../model/order.dart';

class UserOrderProvide with ChangeNotifier {
  List<OrderData> allOrderList = []; // 全部订单
  List<OrderData> unpaidOrderList = []; // 未付款
  List<OrderData> undispatchOrderList = []; // 未发货
  List<OrderData> unreceivedOrderList = []; // 未收货
  Map<int, List<OrderData>> orderListMap = {
    0: [], // 全部订单
    1: [], // 待付款
    2: [], // 待发货
    3: [], // 待收货
  };
  Map<int, String> orderStatusMap = {
    -1: '已取消',
    1: '待付款',
    2: '待发货',
    3: '待收货',
    4: '已完成'
  };
  bool tokenErr = false;
  bool updateSuc;

  // 获取用户订单
  getUserOrder(token, status) async {
    await request('getUserOrder', POST,
        data: {"token": token, "status": status}).then((val) {
      OrderModel res = OrderModel.fromJson(val);
      if (res.code == 0) {
        orderListMap[status] = res.data;
        // classifyOrder(orderList);
      } else if (res.code == -2) {
        tokenErr = true;
      }
    });
    notifyListeners();
  }

  // 订单分类
  classifyOrder(List<OrderData> orderList) {
    orderList.forEach((item) {
      if (item.orderStatus == 1) {
        unpaidOrderList.add(item);
      } else if (item.orderStatus == 2) {
        undispatchOrderList.add(item);
      } else if (item.orderStatus == 3) {
        unreceivedOrderList.add(item);
      }
    });
  }

  updateOrderStatus(token, orderId, status) async {
    var data = {"token": token, "orderId": orderId, "orderStatus": status};
    await request('updateOrderStatus', POST, data: data).then((val) {
      if (val['code'] == 0) {
        updateSuc = true;
      } else if (val['code'] == -2) {
        tokenErr = true;
      } else {
        updateSuc = false;
      }
    });
    await getUserOrder(token, 0);
    // await getUserOrder(token, status - 1);
    notifyListeners();
  }

  getOrderStatusString(int status) {
    return orderStatusMap[status];
  }

  getOrderDetailsByOrderId(String orderId) {
    OrderData orderData =
        orderListMap[0].firstWhere((item) => (item.orderId == orderId));
    print(orderData);
    return orderData;
  }

  transformTime(time) {
    return DateTime(time);
  }
}
