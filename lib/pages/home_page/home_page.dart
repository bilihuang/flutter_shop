import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provide/provide.dart';
import '../../provide/index.dart';
import '../search_page/search_page.dart';
import './swiper.dart';
import './top_navigator.dart';
import './recommend.dart';
import './floor.dart';
import './hot_goods.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller; // 刷新控制器
  // 保持页面状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓食品'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchPage());
              },
            )
          ],
        ),
        // 解决异步渲染的组件
        body: FutureBuilder(
            future: _getIndexData(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provide<IndexProvide>(
                  builder: (context, child, indexData) {
                    var floorName = indexData.floorName;
                    return EasyRefresh(
                      enableControlFinishLoad: true,
                      controller: _controller,
                      footer: ClassicalFooter(
                        bgColor: Colors.white,
                        textColor: Colors.pink,
                        infoColor: Colors.pink,
                        showInfo: true,
                        loadedText: '加载完成',
                        noMoreText: '没有更多了',
                        infoText: '',
                        loadingText: '加载中',
                      ),
                      child: ListView(
                        children: <Widget>[
                          SwiperDiy(swiperDataList: indexData.swipers),
                          TopNavigator(navigatorList: indexData.category),
                          Recommend(recommendList: indexData.recommend),
                          Floor(
                              floorGoodsList: indexData.floorOne,
                              floorTitle: floorName.floor1),
                          Floor(
                              floorGoodsList: indexData.floorTwo,
                              floorTitle: floorName.floor2),
                          Floor(
                              floorGoodsList: indexData.floorThree,
                              floorTitle: floorName.floor3),
                          HotGoods(
                            hotGoodsList: indexData.hotGoods,
                          )
                        ],
                      ),
                      // onLoad: () async {
                      //   print('开始加载更多');
                      //   var data = {'page': page};
                      //   await request('homePageBelowContent', data: data).then((val) {
                      //     var data = json.decode(val.toString());
                      //     if (data['data'] != null) {
                      //       List<Map> newGoodsList = (data['data'] as List).cast();
                      //       setState(() {
                      //         hotGooodsList.addAll(newGoodsList);
                      //         page++;
                      //       });
                      //       _controller.finishLoad(noMore: false);
                      //     } else {
                      //       print('没有更多了');
                      //       _controller.finishLoad(noMore: true);
                      //     }
                      //   });
                      // },
                    );
                  },
                );
              } else {
                return Center(child: Text('加载中……'));
              }
            }));
  }

  // 获取首页数据
  Future _getIndexData(BuildContext context) async {
    await Provide.value<IndexProvide>(context).getIndexData();
    return Provide.value<IndexProvide>(context).indexData;
  }
}
