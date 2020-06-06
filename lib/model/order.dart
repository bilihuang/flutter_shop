class OrderModel {
  int code;
  String msg;
  List<OrderData> data;

  OrderModel({this.code, this.msg, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<OrderData>();
      json['data'].forEach((v) {
        data.add(new OrderData.fromJson(v));
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

class OrderData {
  String orderId;
  double orderPrice;
  int orderStatus;
  String createTime;
  String updateTime;
  AddressInfo addressInfo;
  List<OrderDetails> orderDetails;

  OrderData(
      {this.orderId,
      this.orderPrice,
      this.orderStatus,
      this.createTime,
      this.updateTime,
      this.addressInfo,
      this.orderDetails});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderPrice = json['order_price'].toDouble();
    orderStatus = json['order_status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    addressInfo = json['addressInfo'] != null
        ? new AddressInfo.fromJson(json['addressInfo'])
        : null;
    if (json['orderDetails'] != null) {
      orderDetails = new List<OrderDetails>();
      json['orderDetails'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_price'] = this.orderPrice;
    data['order_status'] = this.orderStatus;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    if (this.addressInfo != null) {
      data['addressInfo'] = this.addressInfo.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressInfo {
  String addressId;
  String recipent;
  String phone;
  String address;

  AddressInfo({this.addressId, this.recipent, this.phone, this.address});

  AddressInfo.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    recipent = json['recipent'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['recipent'] = this.recipent;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

class OrderDetails {
  String orderdetailId;
  String goodsId;
  String goodsName;
  String goodsImage;
  int goodsCount;
  double goodsPrice;

  OrderDetails(
      {this.orderdetailId,
      this.goodsId,
      this.goodsName,
      this.goodsImage,
      this.goodsCount,
      this.goodsPrice});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderdetailId = json['orderdetail_id'];
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    goodsImage = json['goods_image'];
    goodsCount = json['goods_count'];
    goodsPrice = json['goods_price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderdetail_id'] = this.orderdetailId;
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['goods_image'] = this.goodsImage;
    data['goods_count'] = this.goodsCount;
    data['goods_price'] = this.goodsPrice;
    return data;
  }
}
