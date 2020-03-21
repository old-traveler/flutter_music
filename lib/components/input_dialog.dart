import 'package:flutter/material.dart';

/// 展示输入Dialog，取消则无返回信息为null，确认无输入为内容空。可通过此特点区分
Future<String> showInputDialog(BuildContext context,
    {String title, String hint, String confirm, String cancel}) async {
  return await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        String value;
        return Dialog(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title ?? '提示',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(hintText: hint ?? '请输入信息'),
                  onChanged: (text) => value = text,
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonBar(
                  buttonPadding: EdgeInsets.all(0),
                  buttonHeight: 10,
                  children: <Widget>[
                    FlatButton(
                      child: Text(confirm ?? '确定'),
                      onPressed: () {
                        Navigator.of(context).pop(value ?? '');
                      },
                    ),
                    FlatButton(
                      child: Text(
                        cancel ?? '取消',
                        style: TextStyle(color: Colors.black54),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}
