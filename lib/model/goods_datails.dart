class GoodsDetailsModel {
  int code;
  String msg;
  GoodsDetailsData data;

  GoodsDetailsModel({this.code, this.msg, this.data});

  GoodsDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null
        ? new GoodsDetailsData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GoodsDetailsData {
  GoodsInfo goodsInfo;

  GoodsDetailsData({this.goodsInfo});

  GoodsDetailsData.fromJson(Map<String, dynamic> json) {
    goodsInfo = json['goodsInfo'] != null
        ? new GoodsInfo.fromJson(json['goodsInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodsInfo != null) {
      data['goodsInfo'] = this.goodsInfo.toJson();
    }
    return data;
  }
}

class GoodsInfo {
  String goodsId;
  String goodsName;
  double goodsPrice;
  String goodsImage;
  String goodsDetail;

  GoodsInfo(
      {this.goodsId,
      this.goodsName,
      this.goodsPrice,
      this.goodsImage,
      this.goodsDetail});

  GoodsInfo.fromJson(Map<String, dynamic> json) {
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    goodsPrice = json['goods_price'].toDouble();
    goodsImage = json['goods_image'];
    goodsDetail = json['goods_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['goods_price'] = this.goodsPrice;
    data['goods_image'] = this.goodsImage;
    data['goods_detail'] = this.goodsDetail;
    return data;
  }
}
