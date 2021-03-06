import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:music/bloc/smart_state_widget.dart';
import 'package:music/entity/entity_factory.dart';
import 'package:music/util/stream_manager.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef ResponseProvider = Future<dynamic> Function();
typedef ListResponseProvider = Future<dynamic> Function(int page, int offset);
typedef ContentProvider<D> = Widget Function(BuildContext context, D data);
typedef RefreshProvider = void Function();

/// 基础网络逻辑处理者
mixin ResponseWorker {
  StreamManager _streamManager = StreamManager();
  Map<dynamic, RefreshProvider> _refreshProviderMap = {};
  bool hasListen = false;

  StreamManager get streamManager {
    if (!hasListen) {
      hasListen = true;
      _streamManager.getStreamByKey(ResponseWorker).listen((data) {
        if (data is PageMessage &&
            data.messageType == MessageType.refresh &&
            _refreshProviderMap[data.key] != null) {
          _refreshProviderMap[data.key]();
        } else if (dispatchPageMessage(data)) {
          print('message has been deal');
        } else {
          throw Exception('unknow type is ${data.runtimeType}');
        }
      });
    }
    return _streamManager;
  }

  /// 分发页面Message事件，业务可以自定义Message并且处理Message事件
  /// 用于子节点Widget于Bloc通信，可参考无网络点击刷新功能实现
  bool dispatchPageMessage(dynamic data) {
    return false;
  }

  /// 处理Response，用户统一网络加载、网络失败、等状态的管理
  /// 使用时必须传入具体T用于json的解析，新增的Entity需要在[EntityFactory]中添加映射关系
  void dealResponse<T>(
      {@required ResponseProvider responseProvider,
      void Function(bool) stopLoading,
      bool needLoading = true,
      T Function(T) dataConvert}) async {
    assert(responseProvider != null);
    if (needLoading) {
      _sendLoadingState<T>();
    }
    Response response = await responseProvider();
    _refreshProviderMap[T] = () {
      dealResponse(
          responseProvider: responseProvider,
          stopLoading: stopLoading,
          needLoading: needLoading,
          dataConvert: dataConvert);
    };
    if (response == null) {
      dealNonNullFunction(stopLoading, false);
      _streamManager.addDataToSinkByKey(T, PageData<T>.noNet(null));
      return;
    }
    final dataMap = _decodeJson(response);
    bool requestSuccess = false;
    if (dataMap is FormatException) {
      _streamManager.getStreamControllerByKey(T).addError(dataMap.message);
    } else if (dataMap == null) {
      _sendNoDataState<T>();
    } else if (dataMap['status'] == 1 ||
        dataMap['code'] == 0 ||
        dataMap['plist'] != null ||
        dataMap['list'] != null) {
      T originData = EntityFactory.generateOBJ<T>(dataMap);
      final resultData =
          dataConvert == null ? originData : dataConvert(originData);
      _sendContentState<T>(resultData);
      requestSuccess = true;
    } else {
      _sendErrorState<T>(dataMap['error']);
    }
    dealNonNullFunction(stopLoading, requestSuccess);
  }

  dynamic _decodeJson(Response response) {
    String jsonString = response.toString();
    jsonString = jsonString.substring(
        jsonString.indexOf("{"), jsonString.lastIndexOf("}") + 1);
    print("jsonString $jsonString");
    dynamic data;
    try {
      data = json.decode(jsonString);
    } on FormatException catch (e) {
      print(e.message);
      data = e;
    }
    return data;
  }

  void _sendLoadingState<T>() {
    _streamManager.addDataToSinkByKey(T, PageData<T>.loading(null));
  }

  void _sendNoDataState<T>() {
    _streamManager.addDataToSinkByKey(T, PageData<T>.noData(null));
  }

  void _sendContentState<T>(T data) {
    _streamManager.addDataToSinkByKey(T, PageData<T>.complete(data));
  }

  void _sendErrorState<T>(String errorMsg) {
    _streamManager.addDataToSinkByKey(
        T, PageData<String>.error(errorMsg ?? '未知错误'));
  }

  void disposeByKey(key) {
    _streamManager.dispose(key);
    _refreshProviderMap?.remove(key);
  }

  void disposeAll() {
    _streamManager.disposeAll();
    _refreshProviderMap.clear();
  }
}

void dealNonNullFunction(Function(bool isOk) function, bool isOk) {
  if (function != null) {
    function(isOk);
  }
}

enum MessageType { refresh }

class PageMessage {
  MessageType messageType;
  dynamic key;

  PageMessage(this.messageType, this.key);

  PageMessage.refresh(dynamic key) : this(MessageType.refresh, key);
}

enum PageState {
  loading,
  noData,
  noNet,
  complete,
  error,
}

class PageData<D> {
  PageState state;
  D data;

  PageData(this.state, this.data);

  PageData.complete(D data) : this(PageState.complete, data);

  PageData.noData(D data) : this(PageState.noData, data);

  PageData.loading(D data) : this(PageState.loading, data);

  PageData.noNet(D data) : this(PageState.noNet, data);

  PageData.error(D data) : this(PageState.error, data);
}

/// 处理分页逻辑的Worker，使用时需和[ResponseWorker]搭配使用
mixin ListPageWorker on ResponseWorker {
  int _page = 1;
  RefreshController _refreshController;
  BaseListState _baseListState;

  init(BaseListState baseListState) {
    assert(baseListState != null);
    _baseListState = baseListState;
    _refreshController = baseListState.refreshController;
  }

  _fetchListData<T>(
    bool isRefresh,
    ListResponseProvider listResponseProvider,
  ) {
    if (isRefresh) _page = 1;
    dealResponse<T>(
        responseProvider: () {
          return listResponseProvider(
              _page, _baseListState._dataList?.length ?? 0);
        },
        needLoading:
            !(_refreshController.isRefresh || _refreshController.isLoading),
        stopLoading: _onStopLoading);
  }

  void _onStopLoading(bool requestSuccess) {
    if (_page == 1) {
      if (requestSuccess) {
        _refreshController.refreshCompleted();
      } else {
        _refreshController.refreshFailed();
      }
    } else {
      if (requestSuccess) {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadFailed();
      }
    }
    if (requestSuccess) {
      _page++;
    }
  }

  dynamic get widget => _baseListState.widget;

  /// 返回列表加载接口信息
  ListResponseProvider listResponseProvider() {
    return null;
  }
}

/// 列表页面基类，用于处理分页加载事件
abstract class BaseListState<D, W extends StatefulWidget> extends State<W>
    with AutomaticKeepAliveClientMixin {
  final ListPageWorker baseListBloc;
  RefreshController refreshController = RefreshController();
  ListConfig listConfig;
  List<dynamic> _dataList = [];
  List<Widget> headerView = [];
  Map<String, Widget> headerMap = {};

  BaseListState(this.baseListBloc, {this.listConfig});

  Widget itemBuilder(BuildContext context, int index) {
    if (index < headerView.length) {
      return headerView[index];
    }
    int itemIndex = index - headerView.length;
    return buildItem(context, _dataList[itemIndex], itemIndex);
  }

  @override
  void initState() {
    super.initState();
    baseListBloc.init(this);
    listConfig ??= ListConfig();
    if (listConfig.firstLoading) {
      baseListBloc._fetchListData<D>(true, listResponseProvider());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final emptyData =
        (data) => (itemAndHeaderCount + (getListData(data)?.length ?? 0) == 0);
    final contextWidget = InheritedProvider.value(
        value: baseListBloc.streamManager,
        updateShouldNotify: (o, n) => true,
        child: SmartStatePage<D>(
            initialData: listConfig.initData,
            noData: listConfig.noData,
            noNet: listConfig.noNet,
            loading: listConfig.loading,
            error: listConfig.error,
            height: listConfig.height,
            isNoData: emptyData,
            showContentWhenNoNet: (data) => !emptyData(data),
            builder: (context, data) {
              final list = getListData(data);
              if (list?.isNotEmpty ?? false) {
                if (baseListBloc._page == 2) {
                  /// refresh
                  _dataList.clear();
                  headerView.clear();
                  headerMap.clear();
                }
                _dataList.addAll(list);
              }
              buildHeaderWidget(context, data);
              return SmartRefresher(
                enablePullDown: listConfig.enablePullDown,
                enablePullUp: hasNextPage(data),
                controller: refreshController,
                onRefresh: onRefresh,
                onLoading: onLoading,
                header: (listConfig.header ?? ClassicHeader()),
                footer: (listConfig.footer ?? ClassicFooter()),
                child: buildListView(data, itemAndHeaderCount),
              );
            }));
    return wrapContent(contextWidget);
  }

  @protected
  Widget wrapContent(Widget contentWidget) {
    return contentWidget;
  }

  void onRefresh() {
    baseListBloc._fetchListData<D>(true, listResponseProvider());
  }

  void onLoading() {
    baseListBloc._fetchListData<D>(false, listResponseProvider());
  }

  /// 构造Header widget，新增的widget可以添加到[headers]中
  void buildHeaderWidget(BuildContext context, D data) {}

  /// 添加非重复key的header，如果[key]对应的header已经存在则不回调[headerWidgetProvider]
  /// 注意：此方法应该在[buildHeaderWidget]中调用，否则将不会立即生效
  void addHeaderView(String key, Widget Function() headerWidgetProvider) {
    assert(headerWidgetProvider != null);
    if (containsHeader(key)) {
      return;
    }
    final header = headerWidgetProvider();
    headerMap[key] = header;
    headerView.add(header);
  }

  bool containsHeader(String key) {
    return headerMap.containsKey(key);
  }

  /// 获取是否有下一页数据，由子类覆盖实现
  bool hasNextPage(D data);

  int get page => baseListBloc._page;

  /// 构造中心列表控件，子类可覆盖此方法，定义其他列表控件
  /// 注意定义时需要制定itemBuilder为父类的itemBuilder
  Widget buildListView(D data, int itemAndHeaderCount) {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: (_dataList.length + headerView.length),
    );
  }

  /// 获取列表数据请求，子类实现
  ListResponseProvider listResponseProvider() =>
      baseListBloc.listResponseProvider();

  /// 构造item，子类实现
  /// [index]是item的相对下标，即去除了header的count
  Widget buildItem(BuildContext context, dynamic data, int index);

  /// 定义从data中获取list的映射关系，由子类实现
  List<dynamic> getListData(D data);

  List<dynamic> get dataList => _dataList;

  /// 获取item和header的总数量
  int get itemAndHeaderCount => (_dataList.length + headerView.length);

  /// 获取item的总数量
  int get itemCount => _dataList.length;

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
    baseListBloc.disposeAll();
    headerView.clear();
    _dataList.clear();
    headerMap.clear();
  }

  @override
  bool get wantKeepAlive => false;
}

/// [BaseListState]使用的页面配置信息
class ListConfig<D> {
  bool firstLoading;
  D initData;
  PageStateWidgetBuilder noData;
  PageStateWidgetBuilder loading;
  PageErrorWidgetBuilder error;
  NoNetPageStateWidget noNet;
  double height;
  bool enablePullDown;
  Widget header;
  Widget footer;

  ListConfig(
      {this.firstLoading = true,
      this.initData,
      this.noData,
      this.loading,
      this.error,
      this.noNet,
      this.height,
      this.enablePullDown = true,
      this.header,
      this.footer});
}
