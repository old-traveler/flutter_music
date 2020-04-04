import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
      _streamManager.addDataToSinkByKey(T, PageData<T>.loading(null));
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
    String jsonString = response.toString();
    jsonString = jsonString.substring(jsonString.indexOf("{"));
    jsonString = jsonString.substring(0, jsonString.lastIndexOf("}") + 1);
    print("jsonString$jsonString");
    dynamic data;
    try {
      data = json.decode(jsonString);
    } on FormatException catch (e) {
      print('e');
      data = null;
    }
    if (data == null) {
      dealNonNullFunction(stopLoading, false);
      _streamManager.addDataToSinkByKey(T, PageData<T>.noData(null));
      return;
    }
    if (data['status'] == 1 || data['code'] == 0) {
      T originData = EntityFactory.generateOBJ<T>(data);
      _streamManager.addDataToSinkByKey(
          T,
          PageData<T>.complete(
              dataConvert == null ? originData : dataConvert(originData)));
      dealNonNullFunction(stopLoading, true);
      return;
    } else if (data['error'] != null) {
      _streamManager.addDataToSinkByKey(T, PageData<T>.error(data['error']));
    } else {
      _streamManager.addDataToSinkByKey(T, PageData<String>.error("未知错误"));
    }
    dealNonNullFunction(stopLoading, false);
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
              _page, _baseListState.dataList?.length ?? 0);
        },
        needLoading:
            !(_refreshController.isRefresh || _refreshController.isLoading),
        stopLoading: (isOk) {
          if (_page == 1) {
            if (isOk) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else {
            if (isOk) {
              _refreshController.loadComplete();
            } else {
              _refreshController.loadFailed();
            }
          }
          if (isOk) {
            _page++;
          }
        });
  }

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
  List<dynamic> dataList = [];
  List<Widget> headerView = [];

  BaseListState(this.baseListBloc, {this.listConfig});

  Widget itemBuilder(BuildContext context, int index) {
    if (index < headerView.length) {
      return headerView[index];
    }
    int itemIndex = index - headerView.length;
    return buildItem(context, dataList[itemIndex], itemIndex);
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
    return InheritedProvider.value(
        value: baseListBloc.streamManager,
        updateShouldNotify: (o, n) => true,
        child: smartStreamBuilder2<D>(
            initialData: listConfig.initData,
            noData: listConfig.noData,
            noNet: listConfig.noNet,
            loading: listConfig.loading,
            error: listConfig.error,
            height: listConfig.height,
            streamManager: baseListBloc.streamManager,
            isNoData: emptyData,
            showContentWhenNoContent: (data) => !emptyData(data),
            builder: (context, data) {
              final list = getListData(data);
              if (list?.isNotEmpty ?? false) {
                if (baseListBloc._page == 2) {
                  /// refresh
                  dataList.clear();
                  headerView.clear();
                }
                dataList.addAll(list);
              }
              buildHeaderWidget(context, data, headerView);
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
  }

  void onRefresh() {
    baseListBloc._fetchListData<D>(true, listResponseProvider());
  }

  void onLoading() {
    baseListBloc._fetchListData<D>(false, listResponseProvider());
  }

  /// 构造Header widget，新增的widget可以添加到[headers]中
  void buildHeaderWidget(BuildContext context, D data, List<Widget> headers) {}

  /// 获取是否有下一页数据，由子类覆盖实现
  bool hasNextPage(D data);

  /// 构造中心列表控件，子类可覆盖此方法，定义其他列表控件
  /// 注意定义时需要制定itemBuilder为父类的itemBuilder
  Widget buildListView(D data, int itemAndHeaderCount) {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: (dataList.length + headerView.length),
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

  /// 获取item和header的总数量
  int get itemAndHeaderCount => (dataList.length + headerView.length);

  /// 获取item的总数量
  int get itemCount => dataList.length;

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
    baseListBloc.disposeAll();
    headerView.clear();
    dataList.clear();
  }

  @override
  bool get wantKeepAlive => false;
}

/// [BaseListState]使用的页面配置信息
class ListConfig<D> {
  bool firstLoading;
  D initData;
  PageStateWidget noData;
  PageStateWidget loading;
  PageStateWidget error;
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
