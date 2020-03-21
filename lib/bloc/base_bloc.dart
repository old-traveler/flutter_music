import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:music/entity/entity_factory.dart';
import 'package:music/util/stream_manager.dart';

typedef ResponseProvider = Future<dynamic> Function();
typedef ContentProvider<D> = Widget Function(BuildContext context, D data);
typedef RefreshProvider = void Function();

class BaseBloc {
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
          print('message has deal');
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

  void dispose(key) {
    _streamManager.dispose(key);
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
