class CategoryModel {
  int code;
  String msg;
  List<CategoryData> data;

  CategoryModel({this.code, this.msg, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<CategoryData>();
      json['data'].forEach((v) {
        data.add(new CategoryData.fromJson(v));
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

class CategoryData {
  String categoryId;
  String categoryName;
  List<Subcategory> subcategory;

  CategoryData({this.categoryId, this.categoryName, this.subcategory});

  CategoryData.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    if (json['subcategory'] != null) {
      subcategory = new List<Subcategory>();
      json['subcategory'].forEach((v) {
        subcategory.add(new Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  String subcategoryId;
  String subcategoryName;
  String categoryId;

  Subcategory({this.subcategoryId, this.subcategoryName, this.categoryId});

  Subcategory.fromJson(Map<String, dynamic> json) {
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategory_id'] = this.subcategoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['category_id'] = this.categoryId;
    return data;
  }
}
