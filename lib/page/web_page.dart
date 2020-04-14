import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void openWebPage(BuildContext context, url) {
  // 目前只支持Android的浏览器
  if (Platform.isAndroid) {
    Navigator.of(context).pushNamed('web', arguments: url);
  }
}

class WebPage extends StatefulWidget {
  final String url;
  final String title;

  const WebPage({Key key, @required this.url, this.title = ''})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => WebState();
}

class WebState extends State<WebPage> {
  MethodChannel _channel;
  String _title;

  @override
  Widget build(BuildContext context) {
    print("url  ${widget.url}");
    return WillPopScope(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: AndroidView(
          viewType: 'flutterWebView',
          creationParams: {
            'url': widget.url,
          },
          onPlatformViewCreated: onPlatformViewCreated,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  Future<bool> _onWillPop() async {
    bool isBacked = await _channel.invokeMethod('back');
    return !isBacked;
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(_title ?? widget.title),
      actions: <Widget>[
        GestureDetector(
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onTap: reloadUrl,
        ),
        SizedBox(width: 10),
        GestureDetector(
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        SizedBox(width: 14),
      ],
    );
  }

  void reloadUrl() {
    _channel.invokeMethod('reload');
  }

  void onPlatformViewCreated(int id) {
    _channel = MethodChannel('web_view_plugin');
    _channel.setMethodCallHandler(webViewMethodHandler);
  }

  Future<dynamic> webViewMethodHandler(MethodCall call) async {
    if (call.method == 'onReceivedTitle') {
      setState(() {
        _title = call.arguments;
      });
      return true;
    }
    return null;
  }
}
