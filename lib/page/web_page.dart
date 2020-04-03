import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(_title ?? widget.title),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () => backOrPop(),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onTap: reloadUrl,
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(
            width: 14,
          ),
        ],
      ),
      body: AndroidView(
        viewType: 'flutterWebView',
        creationParams: {
          'url': widget.url,
        },
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }

  void backOrPop() async {
    bool isBacked = await _channel.invokeMethod('back');
    if (!isBacked) {
      Navigator.pop(context);
    }
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
