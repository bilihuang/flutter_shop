import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(context, tipText) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Text(tipText),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.pop(context, false), // 关闭对话框
          ),
          FlatButton(
              child: Text("确定"),
              onPressed: () =>
                  //关闭对话框并返回true
                  Navigator.pop(context, true)),
        ],
      );
    },
  );
}
