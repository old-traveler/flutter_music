import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoNetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("无网络"),
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
      child: LinearProgressIndicator(),
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
