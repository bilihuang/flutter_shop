class CategoryGoodsListModel {
  int code;
  String msg;
  List<CategoryGoodsListData> data;

  CategoryGoodsListModel({this.code, this.msg, this.data});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<CategoryGoodsListData>();
      json['data'].forEach((v) {
        data.add(new CategoryGoodsListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryGoodsListData {
  String goodsId;
  String goodsName;
  double goodsPrice;
  String goodsImage;

  CategoryGoodsListData(
      {this.goodsId, this.goodsName, this.goodsPrice, this.goodsImage});

  CategoryGoodsListData.fromJson(Map<String, dynamic> json) {
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    goodsPrice = json['goods_price'].toDouble();
    goodsImage = json['goods_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['goods_price'] = this.goodsPrice;
    data['goods_image'] = this.goodsImage;
    return data;
  }
}
