import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebPage extends StatefulWidget {
  final String url;

  const WebPage({Key key, @required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WebState();
}

class WebState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    print("url  ${widget.url}");
    return Scaffold(
      appBar: AppBar(
        title: Text('酷狗直播'),
      ),
      body: AndroidView(
        viewType: 'flutterWebView',
        creationParams: {
          'url': widget.url,
        },
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}
