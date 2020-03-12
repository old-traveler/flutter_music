import 'dart:async';

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class StreamManager {
  Map<dynamic, StreamController> _streamControllerMap = HashMap();

  static StreamManager of(BuildContext context){
    return Provider.of<StreamManager>(context);
  }

  //推荐使用type作为key
  static Stream getStreamByKey(BuildContext context, dynamic key) {
    return Provider.of<StreamManager>(context)._getStreamByKey(key);
  }

  Stream _getStreamByKey(dynamic key) {
    return (_streamControllerMap[key] ??= StreamController()).stream;
  }

  static void addDataToSinkByContext(BuildContext context, dynamic data) {
    Provider.of<StreamManager>(context)?.addDataToSink(data);
  }

  void addDataToSink(dynamic data) {
    print("controller：${_streamControllerMap[data.runtimeType]}");
    _streamControllerMap[data.runtimeType]?.add(data);
  }

  void disposeAll() {
    _streamControllerMap.forEach((dynamic key, StreamController value) {
      value.close();
    });
  }

  void dispose(dynamic key) {
    _streamControllerMap[key]?.close();
  }
}
