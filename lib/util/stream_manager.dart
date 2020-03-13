import 'dart:async';

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

typedef WidgetBuilder<T> = Widget Function(BuildContext context, T data);

class StreamManager {
  Map<dynamic, StreamController> _streamControllerMap = HashMap();
  Map<dynamic, dynamic> _lastElementMap = HashMap();

  static StreamManager of(BuildContext context) {
    return Provider.of<StreamManager>(context);
  }

  //推荐使用type作为key
  static Stream getStreamByKey(BuildContext context, dynamic key) {
    return Provider.of<StreamManager>(context)._getStreamByKey(key);
  }

  Stream _getStreamByKey(dynamic key) {
    return (_streamControllerMap[key] ??= StreamController.broadcast()).stream;
  }

  static void addDataToSinkByContext(BuildContext context, dynamic data) {
    Provider.of<StreamManager>(context)?.addDataToSink(data);
  }

  static dynamic getLastElement(BuildContext context, dynamic key) {
    return Provider.of<StreamManager>(context)._getLastElement(key);
  }

  dynamic _getLastElement(dynamic key) {
    return _lastElementMap[key];
  }

  void addDataToSink(dynamic data) {
    _lastElementMap[data.runtimeType] = data;
    print("controller：${_streamControllerMap[data.runtimeType]}");
    _streamControllerMap[data.runtimeType]?.add(data);
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

StreamBuilder smartStreamBuilder<T>(
    {@required BuildContext context, @required WidgetBuilder<T> builder}) {
  StreamManager streamManager = Provider.of<StreamManager>(context);
  return StreamBuilder(
    initialData: streamManager._getLastElement(T),
    stream: StreamManager.getStreamByKey(context, T),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot == null || snapshot.data == null) {
        return Container();
      }
      return builder(context, snapshot.data);
    },
  );
}
