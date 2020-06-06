import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_datails.dart';
import './details_top_area.dart';
import './details_explain.dart';
import './details_tabbar.dart';
import './details_image.dart';
import './details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
          future: _getBackInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: ListView(
                      children: <Widget>[
                        DetailsTopArea(),
                        DetailsExplain(),
                        DetailsTabBar(),
                        DetailsImage()
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: DetailsBottom(),
                  )
                ],
              );
            } else {
              return Center(
                child: Text('正在加载中'),
              );
            }
          }),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<GoodsDetailsProvide>(context).getGoodsDetail(goodsId);
    // await Provide.value<GoodsDetailsProvide>(context).getGood();
    return '加载完成';
  }
}
