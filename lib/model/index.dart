class IndexModel {
  int code;
  String msg;
  IndexData data;

  IndexModel({this.code, this.msg, this.data});

  IndexModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new IndexData.fromJson(json['data']) : null;
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

class IndexData {
  List<Swipers> swipers;
  FloorName floorName;
  List<FloorOne> floorOne;
  List<FloorTwo> floorTwo;
  List<FloorThree> floorThree;
  List<Category> category;
  List<Recommend> recommend;
  List<HotGoods> hotGoods;

  IndexData(
      {this.swipers,
      this.floorName,
      this.floorOne,
      this.floorTwo,
      this.floorThree,
      this.category,
      this.recommend,
      this.hotGoods});

  IndexData.fromJson(Map<String, dynamic> json) {
    if (json['swipers'] != null) {
      swipers = new List<Swipers>();
      json['swipers'].forEach((v) {
        swipers.add(new Swipers.fromJson(v));
      });
    }
    floorName = json['floorName'] != null
        ? new FloorName.fromJson(json['floorName'])
        : null;
    if (json['floorOne'] != null) {
      floorOne = new List<FloorOne>();
      json['floorOne'].forEach((v) {
        floorOne.add(new FloorOne.fromJson(v));
      });
    }
    if (json['floorTwo'] != null) {
      floorTwo = new List<FloorTwo>();
      json['floorTwo'].forEach((v) {
        floorTwo.add(new FloorTwo.fromJson(v));
      });
    }
    if (json['floorThree'] != null) {
      floorThree = new List<FloorThree>();
      json['floorThree'].forEach((v) {
        floorThree.add(new FloorThree.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
    if (json['recommend'] != null) {
      recommend = new List<Recommend>();
      json['recommend'].forEach((v) {
        recommend.add(new Recommend.fromJson(v));
      });
    }
    if (json['hotGoods'] != null) {
      hotGoods = new List<HotGoods>();
      json['hotGoods'].forEach((v) {
        hotGoods.add(new HotGoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.swipers != null) {
      data['swipers'] = this.swipers.map((v) => v.toJson()).toList();
    }
    if (this.floorName != null) {
      data['floorName'] = this.floorName.toJson();
    }
    if (this.floorOne != null) {
      data['floorOne'] = this.floorOne.map((v) => v.toJson()).toList();
    }
    if (this.floorTwo != null) {
      data['floorTwo'] = this.floorTwo.map((v) => v.toJson()).toList();
    }
    if (this.floorThree != null) {
      data['floorThree'] = this.floorThree.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.recommend != null) {
      data['recommend'] = this.recommend.map((v) => v.toJson()).toList();
    }
    if (this.hotGoods != null) {
      data['hotGoods'] = this.hotGoods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Swipers {
  String goodsId;
  String goodsName;
  String image;

  Swipers({this.goodsId, this.goodsName, this.image});

  Swipers.fromJson(Map<String, dynamic> json) {
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['image'] = this.image;
    return data;
  }
}

class FloorName {
  String floor1;
  String floor2;
  String floor3;

  FloorName({this.floor1, this.floor2, this.floor3});

  FloorName.fromJson(Map<String, dynamic> json) {
    floor1 = json['floor1'];
    floor2 = json['floor2'];
    floor3 = json['floor3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floor1'] = this.floor1;
    data['floor2'] = this.floor2;
    data['floor3'] = this.floor3;
    return data;
  }
}

class FloorOne {
  String goodsId;
  String goodsName;
  String image;

  FloorOne({this.goodsId, this.goodsName, this.image});

  FloorOne.fromJson(Map<String, dynamic> json) {
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['image'] = this.image;
    return data;
  }
}

class FloorTwo {
  String goodsId;
  String goodsName;
  String image;

  FloorTwo({this.goodsId, this.goodsName, this.image});

  FloorTwo.fromJson(Map<String, dynamic> json) {
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['image'] = this.image;
    return data;
  }
}

class FloorThree {
  String goodsId;
  String goodsName;
  String image;

  FloorThree({this.goodsId, this.goodsName, this.image});

  FloorThree.fromJson(Map<String, dynamic> json) {
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['image'] = this.image;
    return data;
  }
}

class Category {
  String categoryId;
  String categoryName;
  String categoryImage;

  Category({this.categoryId, this.categoryName, this.categoryImage});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    return data;
  }
}

class Recommend {
  String goodsId;
  String goodsName;
  double goodsPrice;
  String goodsImage;

  Recommend({this.goodsId, this.goodsName, this.goodsPrice, this.goodsImage});

  Recommend.fromJson(Map<String, dynamic> json) {
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

class HotGoods {
  String goodsId;
  String goodsName;
  double goodsPrice;
  String goodsImage;

  HotGoods({this.goodsId, this.goodsName, this.goodsPrice, this.goodsImage});

  HotGoods.fromJson(Map<String, dynamic> json) {
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
