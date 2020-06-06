import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/address.dart';
import '../../model/address.dart';
import '../../provide/user.dart';
import '../../routers/application.dart';

class OrderAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<AddressProvide>(builder: (context, child, val) {
      AddressData curAddress =
          Provide.value<AddressProvide>(context).curAddress;
      if (curAddress != null) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black12)),
          child: ListTile(
            leading: Icon(Icons.location_on),
            title: Row(
              children: <Widget>[
                Text('${curAddress.recipent}  '),
                Text(curAddress.phone)
              ],
            ),
            subtitle: Text(curAddress.address),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Application.router.navigateTo(context, '/address?choose=true');
            },
          ),
        );
      } else {
        return Container(
          child: InkWell(
            onTap: () {
              Application.router.navigateTo(context, '/address');
            },
            child: Container(
              child: Text('暂无地址，赶紧点击去添加地址吧'),
            ),
          ),
        );
      }
    });
  }
}
