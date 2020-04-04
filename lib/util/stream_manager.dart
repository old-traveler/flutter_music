import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/components/state_widget.dart';
import 'package:provider/provider.dart';

typedef WidgetBuilder<T> = Widget Function(BuildContext context, T data);
typedef PageStateWidgetBuilder = Widget Function(BuildContext context, double height);
typedef PageErrorWidgetBuilder = Widget Function(
    BuildContext context, Object errorMessage);
typedef NoNetPageStateWidget = Widget Function(
    BuildContext context, VoidCallback callback);
typedef CanShowContent<T> = bool Function(T data);

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


class SmartStatePage<T> extends StatelessWidget {
  final T initialData;
  final WidgetBuilder<T> builder;
  final PageStateWidgetBuilder noData;
  final PageStateWidgetBuilder loading;
  final PageErrorWidgetBuilder error;
  final NoNetPageStateWidget noNet;
  final double height;
  final CanShowContent<T> isNoData;
  final CanShowContent<T> showContentWhenNoNet;

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
      this.showContentWhenNoNet})
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
        if (snapshot.hasError) {
          return _buildErrorWidget(context, snapshot.error);
        }
        if (!snapshot.hasData) {
          return _buildNoDataWidget(context);
        }
        if (!(snapshot.data is PageData)) {
          throw Exception("snapshot.data must is PageData");
        }
        return _buildWidgetByState(context, snapshot.data, streamManager);
      },
    );
  }

  _buildWidgetByState(
      BuildContext context, PageData pageData, StreamManager streamManager) {
    print('pageState ${pageData.state.toString()}');
    switch (pageData.state) {
      case PageState.loading:
        return _buildLoadingWidget(context);
      case PageState.noData:
        return _buildNoDataWidget(context);
      case PageState.complete:
        return _buildContentWidget(context, pageData.data);
      case PageState.error:// 网络请求错误
      case PageState.noNet:
       return _buildNoNetWidget(context, streamManager);
    }
    throw Exception("not deal ${pageData.state}");
  }

  Widget _buildNoDataWidget(BuildContext context) {
    // 处理分页加载某一次数据无数据时，是否展示内容
    if (isNoData == null || isNoData(null)) {
      if (noData != null) {
        return noData(context, height);
      }
      return NoDataWidget('暂无数据');
    }
    return builder(context, null);
  }

  Widget _buildErrorWidget(BuildContext context, Object msg) {
    if (error != null) {
      return error(context, msg);
    }
    return OnErrorWidget(msg);
  }

  Widget _buildLoadingWidget(BuildContext context) {
    if (loading != null) {
      return loading(context, height);
    }
    return LoadingWidget(height);
  }

  Widget _buildContentWidget(BuildContext context, dynamic data) {
    if (isNoData != null && isNoData(data)) {
      return _buildNoDataWidget(context);
    }
    return builder(context, data);
  }
  
  Widget _buildNoNetWidget(BuildContext context,StreamManager streamManager){
    if (showContentWhenNoNet != null &&
        showContentWhenNoNet(null)) {
      return builder(context, null);
    }
    final callback = () => streamManager.addDataToSinkByKey(
        ResponseWorker, PageMessage.refresh(T));
    return noNet != null
        ? noNet(context, callback)
        : NoNetWidget(callback, height);
  }
}
