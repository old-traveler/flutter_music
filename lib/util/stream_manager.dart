import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamManager {
  Map<dynamic, StreamController> _streamControllerMap = {};
  Map<dynamic, dynamic> _lastElementMap = {};

  static StreamManager of(BuildContext context) {
    return Provider.of<StreamManager>(context);
  }

  /// 推荐使用type作为key
  static Stream getStreamByContextAndKey(BuildContext context, dynamic key) {
    return Provider.of<StreamManager>(context).getStreamByKey(key);
  }

  Stream getStreamByKey(dynamic key) {
    return (_streamControllerMap[key] ??= StreamController.broadcast()).stream;
  }

  StreamController getStreamControllerByKey(dynamic key) {
    return (_streamControllerMap[key] ??= StreamController.broadcast());
  }

  static void addDataToSinkByContext(BuildContext context, dynamic data) {
    Provider.of<StreamManager>(context)?.addDataToSink(data);
  }

  static dynamic getLastElementByContext(BuildContext context, dynamic key) {
    return Provider.of<StreamManager>(context).getLastElement(key);
  }

  dynamic getLastElement(dynamic key) {
    return _lastElementMap[key];
  }

  void addDataToSink(dynamic data) {
    addDataToSinkByKey(data.runtimeType, data);
  }

  void addDataToSinkByKey(dynamic key, dynamic data) {
    _lastElementMap[key] = data;
    print("controller：${_streamControllerMap[data.runtimeType]}");
    _streamControllerMap[key]?.add(data);
  }

  void disposeAll() {
    _streamControllerMap.forEach((dynamic key, StreamController value) {
      value.close();
    });
    _streamControllerMap.clear();
    _lastElementMap.clear();
  }

  void dispose(dynamic key) {
    _streamControllerMap[key]?.close();
  }
}
