import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoNetWidget extends StatelessWidget {
  final VoidCallback _voidCallback;
  final double _height;

  NoNetWidget(this._voidCallback, this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'images/no_net.png',
              width: _height == null
                  ? 220
                  : _height * (_height < 200 ? 0.60 : 0.5),
              height: _height == null
                  ? 220
                  : _height * (_height < 200 ? 0.60 : 0.5),
            ),
            SizedBox(
              height: _height == null ? 10 : _height * 0.05,
            ),
            Text(
              '网络出问题啦 ~',
              style: TextStyle(
                  fontSize: _height == null || _height >= 200 ? 15 : 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: _height == null ? 10 : _height * 0.03,
            ),
            GestureDetector(
              child: Text(
                '点击刷新',
                style: TextStyle(
                  fontSize: _height == null || _height >= 200 ? 14 : 9,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: _voidCallback,
            )
          ],
        ));
  }
}

class NoDataWidget extends StatelessWidget {
  final String _title;

  NoDataWidget(this._title);

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
  final double _height;

  LoadingWidget(this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      alignment: Alignment.center,
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
