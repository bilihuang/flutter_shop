import 'package:flutter/material.dart';
import '../../utils/confirm_dialog.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/address.dart';
import '../../routers/application.dart';
import '../../provide/address.dart';
import '../../provide/user.dart';
import '../../utils/toast.dart';

class AddressItem extends StatelessWidget {
  final AddressData item;
  final bool choose;
  AddressItem(this.item, this.choose);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
      decoration: BoxDecoration(color: Colors.white),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Text('${item.recipent}     ${item.phone}'),
            _default(context, item.isdefault)
          ],
        ),
        subtitle: Text(item.address),
        onTap: () {
          if (choose) {
            Provide.value<AddressProvide>(context).setAddress(item);
            Navigator.pop(context);
          }
        },
        trailing: Container(
          width: ScreenUtil().setWidth(200),
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Provide.value<AddressProvide>(context).changeEditAddress(
                        addressId: item.id,
                        recipent: item.recipent,
                        phone: item.phone,
                        address: item.address,
                        isdefault: item.isdefault == 1 ? true : false);
                    Application.router.navigateTo(context, '/addressedit');
                  }),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    bool delete = await showConfirmDialog(context, "确认删除该地址？");
                    if (delete) {
                      var token = Provide.value<UserProvide>(context)
                          .userInfoJson['token'];
                      await Provide.value<AddressProvide>(context)
                          .deleteAddress(token, item.id);
                      var tokenErr =
                          Provide.value<AddressProvide>(context).tokenErr;
                      if (tokenErr) {
                        showToast("token过期,请重新登录");
                        Navigator.of(context).pop();
                        Application.router.navigateTo(context, '/login');
                        return;
                      }
                      if (Provide.value<AddressProvide>(context).deleteSuc) {
                        showToast("删除成功");
                        await Provide.value<AddressProvide>(context)
                            .getAddressList(token);
                      } else {
                        showToast("删除失败");
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
      // child: Column(
      //   children: <Widget>[_addressInfo(item)],
      // ),
    );
  }

  Widget _addressInfo(item) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[],
          ),
          Text("")
        ],
      ),
    );
  }

  Widget _bar(item) {
    return Container(
      child: Row(
        children: <Widget>[],
      ),
    );
  }

  Widget _default(context, isdefault) {
    if (isdefault == 1) {
      return Container(
        padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            border:
                Border.all(width: 1, color: Theme.of(context).primaryColor)),
        child: Text(
          "默认",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: ScreenUtil().setSp(22)),
        ),
      );
    } else {
      return Container();
    }
  }
}
