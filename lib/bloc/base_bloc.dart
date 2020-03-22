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

mixin BaseBloc {
  StreamManager _streamManager = StreamManager();
  Map<dynamic, RefreshProvider> _refreshProviderMap = {};
  bool hasListen = false;

  StreamManager get streamManager {
    if (!hasListen) {
      hasListen = true;
      _streamManager.getStreamByKey(BaseBloc).listen((data) {
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

  bool dispatchPageMessage(dynamic data) {
    return false;
  }

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
      _streamManager.addDataToSinkByKey(T, PageData<T>.noNet(null));
      return;
    }
    String jsonString = response.toString();
    jsonString = jsonString.substring(jsonString.indexOf("{"));
    jsonString = jsonString.substring(0, jsonString.lastIndexOf("}") + 1);
    print("jsonString$jsonString");
    dynamic data = json.decode(jsonString);
    if (data == null) {
      _streamManager.addDataToSinkByKey(T, PageData<T>.noData(null));
      return;
    }
    if (data['status'] == 1 || data['code'] == 0) {
      T originData = EntityFactory.generateOBJ<T>(data);
      _streamManager.addDataToSinkByKey(
          T,
          PageData<T>.complete(
              dataConvert == null ? originData : dataConvert(originData)));
      if (stopLoading != null) {
        stopLoading(true);
      }
      return;
    } else if (data['error'] != null) {
      _streamManager.addDataToSinkByKey(T, PageData<T>.error(data['error']));
    } else {
      _streamManager.addDataToSinkByKey(T, PageData<String>.error("未知错误"));
    }
    if (stopLoading != null) {
      stopLoading(false);
    }
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

/// 列表页面基类
abstract class BaseListState<D, W extends StatefulWidget> extends State<W>
    with AutomaticKeepAliveClientMixin {
  final BaseListBloc baseListBloc;
  RefreshController refreshController = RefreshController();
  ListConfig listConfig;
  List<dynamic> dataList = [];
  List<Widget> headerView = [];

  BaseListState(this.baseListBloc, {this.listConfig});

  Widget itemBuilder(BuildContext context, int index) {
    if (index < headerView.length) {
      return headerView[index];
    }
    return buildItem(context, dataList[index - headerView.length]);
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
            isNoData: (data) => (dataList.length +
                    headerView.length +
                    (getListData(data)?.length ?? 0) ==
                0),
            builder: (context, data) {
              if (baseListBloc._page == 2) {
                /// refresh
                dataList.clear();
                headerView.clear();
              }
              final list = getListData(data);
              if (list?.isNotEmpty ?? false) {
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
  Widget buildItem(BuildContext context, dynamic data);

  /// 定义从data中获取list的映射关系，由子类实现
  List<dynamic> getListData(D data);

  int get itemAndHeaderCount => (dataList.length + headerView.length);

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

mixin BaseListBloc on BaseBloc {
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
            _refreshController.isRefresh && _refreshController.isLoading,
        stopLoading: (isOk) {
          if (_page == 1) {
            _refreshController.refreshCompleted();
          } else {
            _refreshController.loadComplete();
          }
          if (isOk) {
            _page++;
          }
        });
  }

  ListResponseProvider listResponseProvider() {
    return null;
  }
}
