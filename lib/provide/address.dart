import '../config/config.dart';
import '../service/service_method.dart';
import 'package:flutter/material.dart';
import '../model/address.dart';

class AddressProvide with ChangeNotifier {
  List<AddressData> addressList = [];
  Map editAddress = Map();
  AddressData curAddress;
  bool tokenErr = false;
  bool saveSuc;
  bool deleteSuc;

  // 设置当前编辑地址信息
  changeEditAddress({addressId, recipent, phone, address, isdefault}) {
    editAddress['addressId'] =
        addressId == null ? editAddress['addressId'] : addressId;
    editAddress['recipent'] =
        recipent == null ? editAddress['recipent'] : recipent;
    editAddress['phone'] = phone == null ? editAddress['phone'] : phone;
    editAddress['address'] = address == null ? editAddress['address'] : address;
    editAddress['isdefault'] =
        isdefault == null ? editAddress['isdefault'] : isdefault;
    notifyListeners();
  }

  // 获取地址列表
  getAddressList(token) async {
    await request("getAddress", POST, data: {"token": token}).then((val) {
      AddressModel addressRes = AddressModel.fromJson(val);
      if (addressRes.code == 0) {
        addressList = addressRes.data;
      } else if (addressRes.code == -2) {
        tokenErr = true;
      }
    });
    notifyListeners();
  }

  saveAddress(token) async {
    // 若地址id为空说明是新增地址
    if (editAddress['addressId'] == "") {
      var data = {
        "token": token,
        "addressInfo": {
          "recipent": editAddress["recipent"],
          "phone": editAddress["phone"],
          "address": editAddress["address"],
          "isdefault": editAddress["isdefault"]
        }
      };
      await request("createAddress", POST, data: data).then((val) {
        if (val['code'] == 0) {
          saveSuc = true;
        } else if (val['code'] == -2) {
          tokenErr = true;
        } else {
          saveSuc = false;
        }
      });
    } else {
      var data = {
        "token": token,
        "addressInfo": {
          "addressId": editAddress["addressId"],
          "recipent": editAddress["recipent"],
          "phone": editAddress["phone"],
          "address": editAddress["address"],
          "isdefault": editAddress["isdefault"]
        }
      };
      await request("updateAddress", POST, data: data).then((val) {
        if (val['code'] == 0) {
          saveSuc = true;
        } else if (val['code'] == -2) {
          tokenErr = true;
        } else {
          saveSuc = false;
        }
      });
    }
  }

  // // 修改地址
  // updateAddress(token, addressId, recipent, phone, address, isdefault) async {
  //   var data = {
  //     "token": token,
  //     "addressInfo": {
  //       "addressId": addressId,
  //       "recipent": recipent,
  //       "phone": phone,
  //       "address": address,
  //       "isdefault": isdefault
  //     }
  //   };
  //   await request("updateAddress", POST, data: data).then((val) {
  //     if (val['code'] == 0) {
  //       updateSuc = true;
  //     } else if (val['code'] == -2) {
  //       tokenErr = true;
  //     } else {
  //       updateSuc = false;
  //     }
  //   });
  // }

  // // 新增地址
  // createAddress(token, recipent, phone, address, isdefault) async {
  //   var data = {
  //     "token": token,
  //     "addressInfo": {
  //       "recipent": recipent,
  //       "phone": phone,
  //       "address": address,
  //       "isdefault": isdefault
  //     }
  //   };

  //   await request("createAddress", POST, data: data).then((val) {
  //     if (val['code'] == 0) {
  //       createSuc = true;
  //     } else if (val['code'] == -2) {
  //       tokenErr = true;
  //     } else {
  //       createSuc = false;
  //     }
  //   });
  // }

  // 删除地址
  deleteAddress(token, id) async {
    var data = {"token": token, "addressId": id};

    await request('deleteAddress', POST, data: data).then((val) {
      if (val['code'] == 0) {
        deleteSuc = true;
      } else if (val['code'] == -2) {
        tokenErr = true;
      } else {
        deleteSuc = false;
      }
    });
  }

  // 设置当前订单地址
  setAddress(AddressData address) {
    curAddress = address;
    notifyListeners();
  }

  // 初始化默认订单地址
  getDefaultAddress(token) async {
    await request("getDefaultAddress", POST, data: {"token": token})
        .then((val) {
      AddressModel addressRes = AddressModel.fromJson(val);
      if (addressRes.code == 0) {
        curAddress = addressRes.data.first;
      } else if (addressRes.code == -2) {
        tokenErr = true;
      }
    });
    notifyListeners();
    return curAddress;
  }
}
