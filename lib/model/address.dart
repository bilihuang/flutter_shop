class AddressModel {
  int code;
  String msg;
  List<AddressData> data;

  AddressModel({this.code, this.msg, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<AddressData>();
      json['data'].forEach((v) {
        data.add(new AddressData.fromJson(v));
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

class AddressData {
  String id;
  int userId;
  String recipent;
  String phone;
  String address;
  int isdefault;

  AddressData(
      {this.id,
      this.userId,
      this.recipent,
      this.phone,
      this.address,
      this.isdefault});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    recipent = json['recipent'];
    phone = json['phone'];
    address = json['address'];
    isdefault = json['isdefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['recipent'] = this.recipent;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['isdefault'] = this.isdefault;
    return data;
  }
}
