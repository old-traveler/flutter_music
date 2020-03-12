import 'dart:async';

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class StreamManager {
  Map<dynamic, StreamController> _streamControllerMap = HashMap();

  //推荐使用type作为key
  static Stream getStreamByKey(BuildContext context, dynamic key) {
    return Provider.of<StreamManager>(context)._getStreamByKey(key);
  }

  Stream _getStreamByKey(dynamic key) {
    _streamControllerMap[key] ??= StreamController();
    return _streamControllerMap[key].stream;
  }

  static void addDataToSinkByContext(BuildContext context, dynamic data) {
    Provider.of<StreamManager>(context)?.addDataToSink(data);
  }

  void addDataToSink(dynamic data) {
    print("controller：${_streamControllerMap[data.runtimeType]}");
    _streamControllerMap[data.runtimeType]?.add(data);
  }

  void dispose() {
    _streamControllerMap.forEach((dynamic key, StreamController value) {
      value.close();
    });
  }
}
