import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/components/state_widget.dart';
import 'package:provider/provider.dart';

typedef WidgetBuilder<T> = Widget Function(BuildContext context, T data);
typedef PageStateWidget = Widget Function(BuildContext context);
typedef NoNetPageStateWidget = Widget Function(
    BuildContext context, VoidCallback callback);
typedef IsShowContent<T> = bool Function(T data);

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

Widget getNonNullWidget(BuildContext context, PageStateWidget widgetProvider,
    Widget Function() defaultWidget) {
  assert(defaultWidget != null);
  if (widgetProvider != null) {
    return widgetProvider(context);
  }
  return defaultWidget();
}

class SmartStatePage<T> extends StatelessWidget {
  final T initialData;
  final WidgetBuilder<T> builder;
  final PageStateWidget noData;
  final PageStateWidget loading;
  final PageStateWidget error;
  final NoNetPageStateWidget noNet;
  final double height;
  final IsShowContent<T> isNoData;
  final IsShowContent<T> showContentWhenNoContent;

  SmartStatePage(
      {Key key,
        this.builder,
        this.initialData,
        this.noData,
        this.loading,
        this.error,
        this.noNet,
        this.height,
        this.isNoData,
        this.showContentWhenNoContent})
      : assert(builder != null),
        assert(height == null || height >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final streamManager = Provider.of<StreamManager>(context);
    return StreamBuilder(
      initialData: initialData != null
          ? PageData.complete(initialData)
          : streamManager.getLastElement(T),
      stream: streamManager.getStreamByKey(T),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot == null || snapshot.data == null) {
          return getNonNullWidget(
              context, noData, () => NoDataWidget('暂无数据'));
        }
        if (!(snapshot.data is PageData)) {
          throw Exception("snapshot.data must is PageData");
        }
        PageData pageData = snapshot.data;
        print('pageState ${pageData.state.toString()}');
        switch (pageData.state) {
          case PageState.loading:
            return getNonNullWidget(
                context, loading, () => LoadingWidget(height));
          case PageState.noData:
            if (isNoData == null || isNoData(null)) {
              return getNonNullWidget(
                  context, noData, () => NoDataWidget('暂无数据'));
            }
            return builder(context, null);
          case PageState.complete:
            if (isNoData != null && isNoData(pageData.data)) {
              return getNonNullWidget(
                  context, noData, () => NoDataWidget('暂无数据'));
            } else {
              return builder(context, pageData.data);
            }
            break;
          case PageState.error:
          case PageState.noNet:
            if (showContentWhenNoContent != null &&
                showContentWhenNoContent(null)) {
              return builder(context, null);
            }
            final callback = () => streamManager.addDataToSinkByKey(
                ResponseWorker, PageMessage.refresh(T));
            return noNet != null
                ? noNet(context, callback)
                : NoNetWidget(callback, height);
        }
        throw Exception("not deal ${pageData.state}");
      },
    );
  }
}

