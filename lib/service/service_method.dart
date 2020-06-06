import 'package:dio/dio.dart';
import 'dart:async';
import '../config/config.dart';
import '../config/service_url.dart';

Future request(url, method, {data}) async {
  try {
    Response response;
    Dio dio = new Dio();

    if (method == GET) {
      if (data == null) {
        response = await dio.get(servicePath[url]);
      } else {
        response = await dio.get(servicePath[url], queryParameters: data);
      }
    } else if (method == POST) {
      if (data == null) {
        response = await dio.post(servicePath[url]);
      } else {
        response = await dio.post(servicePath[url], data: data);
      }
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      // 抛出异常
      throw Exception('接口异常');
    }
  } catch (e) {
    return print('ERROR==>$e');
  }
}

Future requestGet(url, {data}) async {
  try {
    Response response;
    Dio dio = new Dio();
    if (data == null) {
      response = await dio.get(servicePath[url]);
    } else {
      response = await dio.get(servicePath[url], queryParameters: data);
    }
    if (response.statusCode == 200) {
      // print(response.data);
      return response.data;
    } else {
      // 抛出异常
      throw Exception('接口异常');
    }
  } catch (e) {
    return print('ERROR==>$e');
  }
}

// 获取首页主体内容
Future getHomePageContent() async {
  try {
    print('开始获取首页数据');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    // response = await dio.get(servicePath['homePageContent']);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      // 抛出异常
      throw Exception('接口异常');
    }
  } catch (e) {
    return print('ERROR==>$e');
  }
}

// 获取商城首页火爆专区
Future getHomePageBelowContent() async {
  try {
    print('开始获取火爆专区数据');
    Response response;
    Dio dio = new Dio();
    int page = 1; // 分页页数
    dio.options.contentType = Headers.formUrlEncodedContentType;
    response = await dio.post(servicePath['homePageBelowContent'], data: page);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      // 抛出异常
      throw Exception('接口异常');
    }
  } catch (e) {
    return print('ERROR==>$e');
  }
}
