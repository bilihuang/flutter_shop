import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';
import 'package:provide/provide.dart';
import '../../provide/address.dart';
import '../../provide/user.dart';
import 'address_item.dart';

class AddressPage extends StatelessWidget {
  final bool choose; // 判断是个人中心进入还是订单页进入，true为订单页
  AddressPage(this.choose);

  @override
  Widget build(BuildContext context) {
    var token = Provide.value<UserProvide>(context).userInfoJson["token"];
    return Scaffold(
      appBar: AppBar(
        title: Text(choose ? '选择地址' : '地址管理'),
      ),
      body: FutureBuilder(
          future: _getAddress(context, token),
          builder: (context, snapshot) {
            return Provide<AddressProvide>(builder: (context, child, val) {
              var addressList =
                  Provide.value<AddressProvide>(context).addressList;
              return Container(
                width: ScreenUtil().setWidth(750),
                child: ListView.builder(
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    return AddressItem(addressList[index], choose);
                  },
                ),
              );
            });
          }),
      persistentFooterButtons: <Widget>[
        Container(
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(70),
          alignment: Alignment.center,
          child: InkWell(
            child: Text(
              "新增地址",
              style: TextStyle(fontSize: ScreenUtil().setSp(36)),
            ),
            onTap: () {
              Provide.value<AddressProvide>(context).changeEditAddress(
                  addressId: "",
                  recipent: "",
                  phone: "",
                  address: "",
                  isdefault: false);
              Application.router.navigateTo(context, '/addressedit');
            },
          ),
        )
      ],
    );
  }

  Future _getAddress(context, token) async {
    return await Provide.value<AddressProvide>(context).getAddressList(token);
  }
}
