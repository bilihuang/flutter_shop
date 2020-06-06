import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static String searchPage = '/search';
  static String speakPage = '/speak';
  static String loginPage = '/login';
  static String signinPage = '/signin';
  static String userPage = '/user';
  static String addressPage = '/address';
  static String orderPage = '/order';
  static String userOrderPage = '/userorder';
  static String orderDetailPage = '/orderdetail';
  static String addressEditPage = '/addressedit';
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print('ERROR===> ROUTE WAS NOT FOUND!!!');
    });

    // 路由配置
    router
      ..define(detailsPage, handler: detailsHandler)
      ..define(searchPage, handler: searchPageHandler)
      ..define(speakPage, handler: speakPageHandler)
      ..define(loginPage, handler: loginPageHandler)
      ..define(signinPage, handler: signinPageHandler)
      ..define(userPage, handler: userPageHandler)
      ..define(addressPage, handler: addressPageHandler)
      ..define(orderPage, handler: orderPageHandler)
      ..define(userOrderPage, handler: userOrderPageHandler)
      ..define(orderDetailPage, handler: orderDetailPageHandler)
      ..define(addressEditPage, handler: addressEditPageHandler);
  }
}
