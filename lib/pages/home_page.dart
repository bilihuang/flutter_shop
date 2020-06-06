// import 'package:flutter/material.dart';
// import '../service/service_method.dart';
// import 'dart:convert';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_easyrefresh/easy_refresh.dart';
// import '../routers/application.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with AutomaticKeepAliveClientMixin {
//   int page = 1;
//   List<Map> hotGooodsList = []; // 火爆专区商品数组
//   EasyRefreshController _controller; // 刷新控制器
//   // 保持页面状态
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     _controller = EasyRefreshController();
//     _getHotGoods();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var formData = {'lon': '115.02932', 'lat': '35.76189'};
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('百姓生活'),
//       ),
//       // 解决异步渲染的组件
//       body: FutureBuilder(
//           future: request('homePageContent', data: formData),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               // 数据处理
//               // var data = snapshot.data;
//               var data = json.decode(snapshot.data);
//               // cast() 将List的泛型提升到其父祖类
//               List<Map> swiperList = (data['data']['slides'] as List).cast();
//               List<Map> navigatorList =
//                   (data['data']['category'] as List).cast();
//               String adPicture =
//                   data['data']['advertesPicture']['PICTURE_ADDRESS'];
//               String leaderImage = data['data']['shopInfo']['leaderImage'];
//               String leaderPhone = data['data']['shopInfo']['leaderPhone'];
//               List<Map> recommendList =
//                   (data['data']['recommend'] as List).cast();
//               // Map floorName = data['data']['floorName'];
//               String floor1Title =
//                   data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
//               String floor2Title =
//                   data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
//               String floor3Title =
//                   data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
//               List<Map> floor1 = (data['data']['floor1'] as List).cast();
//               List<Map> floor2 = (data['data']['floor2'] as List).cast();
//               List<Map> floor3 = (data['data']['floor3'] as List).cast();
//               return EasyRefresh(
//                 enableControlFinishLoad: true,
//                 controller: _controller,
//                 footer: ClassicalFooter(
//                   bgColor: Colors.white,
//                   textColor: Colors.pink,
//                   infoColor: Colors.pink,
//                   showInfo: true,
//                   loadedText: '加载完成',
//                   noMoreText: '没有更多了',
//                   infoText: '',
//                   loadingText: '加载中',
//                 ),
//                 child: ListView(
//                   children: <Widget>[
//                     SwiperDiy(swiperDataList: swiperList),
//                     TopNavigator(navigatorList: navigatorList),
//                     AdBanner(adPicture: adPicture),
//                     LeaderPhone(
//                       leaderImage: leaderImage,
//                       leaderPhone: leaderPhone,
//                     ),
//                     Recommend(recommendList: recommendList),
//                     Floor(floorGoodsList: floor1, floorTitle: floor1Title),
//                     Floor(floorGoodsList: floor2, floorTitle: floor2Title),
//                     Floor(floorGoodsList: floor3, floorTitle: floor3Title),
//                     _hotGoods()
//                     // HotGoods()
//                   ],
//                 ),
//                 onLoad: () async {
//                   print('开始加载更多');
//                   var data = {'page': page};
//                   await request('homePageBelowContent', data: data).then((val) {
//                     var data = json.decode(val.toString());
//                     if (data['data'] != null) {
//                       List<Map> newGoodsList = (data['data'] as List).cast();
//                       setState(() {
//                         hotGooodsList.addAll(newGoodsList);
//                         page++;
//                       });
//                       _controller.finishLoad(noMore: false);
//                     } else {
//                       print('没有更多了');
//                       _controller.finishLoad(noMore: true);
//                     }
//                   });
//                 },
//               );
//             } else {
//               return Center(child: Text('加载中……'));
//             }
//           }),
//     );
//   }

//   // 获取火爆专区数据
//   void _getHotGoods() {
//     var data = {'page': page};
//     request('homePageBelowContent', data: data).then((val) {
//       var data = json.decode(val.toString());
//       List<Map> newGoodsList = (data['data'] as List).cast();
//       setState(() {
//         hotGooodsList.addAll(newGoodsList);
//         page++;
//       });
//     });
//   }

//   Widget hotTitle = Container(
//     margin: EdgeInsets.only(top: 5),
//     alignment: Alignment.center,
//     padding: EdgeInsets.all(5),
//     child: Text('火爆专区'),
//   );

//   Widget _wrapList() {
//     if (hotGooodsList.length != 0) {
//       List<Widget> listWidget = hotGooodsList.map((val) {
//         return InkWell(
//           onTap: () {
//             Application.router
//                 .navigateTo(context, "/detail?id=${val['goodsId']}");
//           },
//           child: Container(
//             width: ScreenUtil().setWidth(372),
//             color: Colors.white,
//             padding: EdgeInsets.all(5),
//             margin: EdgeInsets.only(bottom: 3),
//             child: Column(
//               children: <Widget>[
//                 Image.network(val['image'], width: ScreenUtil().setWidth(370)),
//                 Text(val['name'],
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                         color: Colors.pink, fontSize: ScreenUtil().setSp(26))),
//                 Row(
//                   children: <Widget>[
//                     Text('￥${val['mallPrice']}'),
//                     Text('￥${val['price']}',
//                         style: TextStyle(
//                             color: Colors.black26,
//                             decoration: TextDecoration.lineThrough))
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       }).toList();

//       return Wrap(
//         spacing: 2,
//         children: listWidget,
//       );
//     } else {
//       return Text('');
//     }
//   }

//   Widget _hotGoods() {
//     return Container(
//       child: Column(
//         children: <Widget>[hotTitle, _wrapList()],
//       ),
//     );
//   }
// }

// // 首页轮播组件
// class SwiperDiy extends StatelessWidget {
//   final List swiperDataList; // 轮播数据数组
//   SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // 设置屏幕适配尺寸
//     return Container(
//       // 所有尺寸均用screenUtil
//       height: ScreenUtil().setHeight(320),
//       width: ScreenUtil().setWidth(750),
//       child: Swiper(
//         itemBuilder: (BuildContext context, int index) {
//           return Image.network('${swiperDataList[index]['image']}',
//               fit: BoxFit.fill);
//         },
//         itemCount: swiperDataList.length,
//         pagination: SwiperPagination(),
//         autoplay: true,
//       ),
//     );
//   }
// }

// // 顶部导航
// class TopNavigator extends StatelessWidget {
//   final List navigatorList;
//   // 构造函数调用简便写法，不推荐
//   TopNavigator({this.navigatorList});

//   Widget _gridViewItemUI(BuildContext context, item) {
//     // 水波纹组件
//     return InkWell(
//       onTap: () {
//         print('点击了导航');
//       },
//       child: Column(
//         children: <Widget>[
//           Image.network(
//             item['image'],
//             width: ScreenUtil().setWidth(95),
//           ),
//           Text(item['mallCategoryName'])
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: ScreenUtil().setHeight(246),
//       padding: EdgeInsets.all(3),
//       child: GridView.count(
//         // 每行5个
//         crossAxisCount: 5,
//         padding: EdgeInsets.all(5),
//         // 禁用滑动，防止出现上下拉阴影
//         physics: NeverScrollableScrollPhysics(),
//         children: navigatorList
//             .map((item) => _gridViewItemUI(context, item))
//             .toList(),
//       ),
//     );
//   }
// }

// // 广告区域
// class AdBanner extends StatelessWidget {
//   final String adPicture;
//   AdBanner({Key key, this.adPicture}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Image.network(adPicture),
//     );
//   }
// }

// // 拨打电话
// class LeaderPhone extends StatelessWidget {
//   final String leaderImage;
//   final String leaderPhone;
//   LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: InkWell(
//         onTap: _launcherURL,
//         child: Image.network(leaderImage),
//       ),
//     );
//   }

//   void _launcherURL() async {
//     String url = 'tel:' + leaderPhone;
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'URL不能进行访问';
//     }
//   }
// }

// // 商品推荐
// class Recommend extends StatelessWidget {
//   final List recommendList;
//   Recommend({Key key, this.recommendList}) : super(key: key);

//   // 标题
//   Widget _titleWidget() {
//     return Container(
//       alignment: Alignment.centerLeft,
//       padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border:
//               Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
//       child: Text(
//         '商品推荐',
//         style: TextStyle(color: Colors.pink),
//       ),
//     );
//   }

//   // 商品项
//   Widget _item(index) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         height: ScreenUtil().setHeight(340),
//         width: ScreenUtil().setWidth(250),
//         padding: EdgeInsets.all(4),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border:
//                 Border(left: BorderSide(width: 0.5, color: Colors.black12))),
//         child: Column(
//           children: <Widget>[
//             Image.network(recommendList[index]['image']),
//             Text(
//               '${recommendList[index]['goodsName']}',
//               textAlign: TextAlign.center,
//               style: TextStyle(),
//             ),
//             Text('￥${recommendList[index]['mallPrice']}'),
//             Text(
//               '￥${recommendList[index]['price']}',
//               style: TextStyle(
//                   decoration: TextDecoration.lineThrough, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 横向列表方法
//   Widget _recommendList() {
//     return Container(
//       height: ScreenUtil().setHeight(340),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: recommendList.length,
//         itemBuilder: (context, index) => _item(index),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: ScreenUtil().setHeight(390),
//       margin: EdgeInsets.only(top: 10),
//       child: Column(
//         children: <Widget>[_titleWidget(), _recommendList()],
//       ),
//     );
//   }
// }

// // 楼层标题
// class FloorTitle extends StatelessWidget {
//   final String pictureAddress;
//   FloorTitle({Key key, this.pictureAddress}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       child: Image.network(pictureAddress),
//     );
//   }
// }

// // 楼层商品列表
// class Floor extends StatelessWidget {
//   final List floorGoodsList;
//   final String floorTitle;
//   Floor({Key key, this.floorGoodsList, this.floorTitle}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[_title(), _firstRow(), _otherFloorGoods()],
//       ),
//     );
//   }

//   // Widget _title() {
//   //   return Container(
//   //     alignment: Alignment.center,
//   //     child: Text(floorName),
//   //   );
//   // }

//   // 标题图片
//   Widget _title() {
//     return Container(
//       padding: EdgeInsets.all(8),
//       child: Image.network(floorTitle),
//     );
//   }

//   Widget _firstRow() {
//     return Row(
//       children: <Widget>[
//         _goodsItem(floorGoodsList[0]),
//         Column(
//           children: <Widget>[
//             _goodsItem(floorGoodsList[1]),
//             _goodsItem(floorGoodsList[2]),
//           ],
//         )
//       ],
//     );
//   }

//   Widget _otherFloorGoods() {
//     return Row(
//       children: <Widget>[
//         _goodsItem(floorGoodsList[3]),
//         _goodsItem(floorGoodsList[4]),
//       ],
//     );
//   }

//   Widget _goodsItem(Map goods) {
//     return Container(
//       width: ScreenUtil().setWidth(375),
//       child: InkWell(
//           onTap: () {
//             print('点击了楼层商品');
//           },
//           child: Image.network(goods['image'])),
//     );
//   }
// }

// // 火爆专区
// // class HotGoods extends StatefulWidget {
// //   @override
// //   _HotGoodsState createState() => _HotGoodsState();
// // }

// // class _HotGoodsState extends State<HotGoods> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     request('homePageBelowContent', data: 1).then((val) {
// //       print('val');
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Text('111'),
// //     );
// //   }
// // }
