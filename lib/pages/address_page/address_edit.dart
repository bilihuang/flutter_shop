import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/address.dart';
import '../../provide/user.dart';
import '../../utils/toast.dart';
import '../../routers/application.dart';

class AddressEditPage extends StatefulWidget {
  // final String recipent; // 收件人姓名
  // final String phone; // 电话
  // final String address; // 地址
  // final bool isdefault; // 是否默认地址
  // AddressEditPage({this.recipent, this.phone, this.address, this.isdefault});
  @override
  _AddressEditPageState createState() => _AddressEditPageState();
  // recipent: recipent, phone: phone, address: address, isdefault: isdefault);
}

class _AddressEditPageState extends State<AddressEditPage> {
  // String recipent; // 收件人姓名
  // String phone; // 电话
  // String address; // 地址
  // bool isdefault; // 是否默认地址
  GlobalKey _formKey = GlobalKey<FormState>();
  FocusNode _blankFocus = FocusNode(); // 点击空白处的焦点
  // TextEditingController _recipentController = TextEditingController();
  // TextEditingController _phoneController = TextEditingController();
  // TextEditingController _addressController = TextEditingController();

  // _AddressEditPageState(
  //     {this.recipent, this.phone, this.address, this.isdefault});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑地址"),
      ),
      body: Provide<AddressProvide>(
        builder: (context, child, val) {
          return GestureDetector(
              onTap: () {
                // 点击空白区域回收键盘
                FocusScope.of(context).requestFocus(_blankFocus);
              },
              child: Container(
                child: ListView(
                  children: <Widget>[
                    _form(context),
                    _default(context),
                    _submitBtn(context)
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget _form(context) {
    String recipent =
        Provide.value<AddressProvide>(context).editAddress['recipent'];
    String phone = Provide.value<AddressProvide>(context).editAddress['phone'];
    String address =
        Provide.value<AddressProvide>(context).editAddress['address'];
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Form(
          key: _formKey,
          // autovalidate: true,
          child: Column(children: <Widget>[
            TextFormField(
              // controller: _recipentController,
              autofocus: false,
              decoration: InputDecoration(
                labelText: '姓名',
                hintText: '请输入收货人姓名',
              ),
              initialValue: recipent == "" ? null : recipent,
              validator: (v) {
                return v.trim().isNotEmpty ? null : '姓名不能为空';
              },
              onSaved: (value) {
                Provide.value<AddressProvide>(context)
                    .changeEditAddress(recipent: value);
              },
            ),
            TextFormField(
              // controller: _phoneController,
              autofocus: false,
              decoration: InputDecoration(
                labelText: '电话',
                hintText: '请输入11位手机号码',
              ),
              initialValue: phone == "" ? null : phone,
              validator: (v) {
                var phoneNumber = v.trim();
                if (phoneNumber.isEmpty) {
                  return "电话不能为空";
                } else if (phoneNumber.length != 11) {
                  return "电话必须为11位号码";
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                Provide.value<AddressProvide>(context)
                    .changeEditAddress(phone: value);
              },
            ),
            TextFormField(
              // controller: _addressController,
              autofocus: false,
              decoration: InputDecoration(
                labelText: '地址',
                hintText: '请输入收货地址',
              ),
              initialValue: address == "" ? null : address,
              validator: (v) {
                return v.trim().isNotEmpty ? null : '地址不能为空';
              },
              onSaved: (value) {
                Provide.value<AddressProvide>(context)
                    .changeEditAddress(address: value);
              },
            ),
          ])),
    );
  }

  Widget _default(context) {
    bool isdefault =
        Provide.value<AddressProvide>(context).editAddress['isdefault'];
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
              value: isdefault,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (bool val) {
                Provide.value<AddressProvide>(context)
                    .changeEditAddress(isdefault: val);
              }),
          Text(
            '设置为默认地址',
            style: TextStyle(fontSize: ScreenUtil().setSp(32)),
          )
        ],
      ),
    );
  }

  // 保存按钮
  Widget _submitBtn(context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(400),
      height: ScreenUtil().setHeight(100),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () async {
          // 点击登录回收键盘
          FocusScope.of(context).requestFocus(_blankFocus);
          if ((_formKey.currentState as FormState).validate()) {
            // 保存数据
            (_formKey.currentState as FormState).save();
            var token =
                Provide.value<UserProvide>(context).userInfoJson['token'];
            await Provide.value<AddressProvide>(context).saveAddress(token);
            var tokenErr = Provide.value<AddressProvide>(context).tokenErr;
            if (tokenErr) {
              showToast("token过期,请重新登录");
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Application.router.navigateTo(context, '/login');
              return;
            }
            if (Provide.value<AddressProvide>(context).saveSuc) {
              showToast("保存成功");
              Navigator.of(context).pop();
            } else {
              showToast("保存失败");
            }
            // await Provide.value<UserProvide>(context)
            //     .login(_userName, _password);
            // if (Provide.value<UserProvide>(context).isLogin) {
            //   showToast("登录成功");
            //   Navigator.of(context).pop(); // 登录成功回到上一页
            // } else {
            //   String loginResult =
            //       Provide.value<UserProvide>(context).loginResult;
            //   showToast(loginResult);
            // }
          }
        },
        child: Text(
          '保   存',
          style: TextStyle(fontSize: ScreenUtil().setSp(36)),
        ),
      ),
    );
  }
}
