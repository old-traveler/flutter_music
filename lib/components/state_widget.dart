import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoNetWidget extends StatelessWidget {
  final VoidCallback _voidCallback;

  NoNetWidget(this._voidCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'images/no_net.png',
              width: 220,
              height: 220,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '网络出问题啦 ~',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            FlatButton(
              child: Text(
                '点击刷新',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: _voidCallback,
            )
          ],
        ));
  }
}

// ignore: must_be_immutable
class NoDataWidget extends StatelessWidget {
  String _title;

  NoDataWidget({title}) {
    _title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'images/no_data.png',
              width: 220,
              height: 220,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _title ?? '暂无数据',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ));
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        child: LinearProgressIndicator(),
      ),
    );
  }
}

class OnErrorWidget extends StatelessWidget {
  final String _msg;

  OnErrorWidget(this._msg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_msg),
    );
  }
}
