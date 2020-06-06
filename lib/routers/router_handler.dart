import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/order_page/order_page.dart';
import '../pages/search_page/search_page.dart';
import '../pages/details_page/details_page.dart';
import '../pages/search_page/speak_page.dart';
import '../pages/login/login_page.dart';
import '../pages/signin_page/signin_page.dart';
import '../pages/user_page/user_page.dart';
import '../pages/address_page/address_page.dart';
import '../pages/userorder_page/userorder_page.dart';
import '../pages/order_detail_page/order_detail_page.dart';
import '../pages/address_page/address_edit.dart';

Handler detailsHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String goodsId = params['id'].first;
  return DetailsPage(goodsId);
});

Handler searchPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String searchWord = params['word'].first;
  SearchPage(query: searchWord);
});

Handler speakPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SpeakPage();
});

Handler loginPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return LoginPage();
});

Handler signinPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SigninPage();
});

Handler userPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return UserPage();
});

Handler addressPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  bool choose = params['choose'].first == 'true' ? true : false;
  return AddressPage(choose);
});

Handler orderPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return OrderPage();
});

Handler userOrderPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return UserOrderPage();
});

Handler orderDetailPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String orderId = params['orderId'].first;
  return OrderDetailPage(orderId);
});

Handler addressEditPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  // String recipent = params['recipent'].first;
  // String phone = params['phone'].first;
  // String address = params['address'].first;
  // bool isdefault = params['isdefault'].first == 'false' ? false : true;
  return AddressEditPage();
  // recipent: recipent, phone: phone, address: address, isdefault: isdefault);
});
