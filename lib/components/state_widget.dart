import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoNetWidget extends StatelessWidget {
  final VoidCallback _voidCallback;

  NoNetWidget(this._voidCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: Text("无网络,点击刷新"),
        onPressed: _voidCallback,
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("无数据"),
    );
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
