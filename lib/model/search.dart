class SearchModel {
  int code;
  String msg;
  List<SearchData> data;

  SearchModel({this.code, this.msg, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<SearchData>();
      json['data'].forEach((v) {
        data.add(new SearchData.fromJson(v));
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

class SearchData {
  String goodsId;
  String goodsName;
  double goodsPrice;
  String goodsImage;

  SearchData({this.goodsId, this.goodsName, this.goodsPrice, this.goodsImage});

  SearchData.fromJson(Map<String, dynamic> json) {
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
