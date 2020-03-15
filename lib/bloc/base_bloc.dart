import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:music/entity/entity_factory.dart';
import 'package:music/util/stream_manager.dart';

typedef ResponseProvider = Future<dynamic> Function();
typedef ContentProvider<D> = Widget Function(BuildContext context,D data);

class BaseBloc {
  StreamManager _streamManager = StreamManager();

  StreamManager get streamManager => _streamManager;

  void dealResponse<T>({@required ResponseProvider responseProvider,void Function(bool) stopLoading}) async {
    assert(responseProvider != null);
    _streamManager.addDataToSinkByKey(T, PageData<T>.loading(null));
    Response response = await responseProvider();
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
      _streamManager.addDataToSinkByKey(
          T, PageData<T>.complete(EntityFactory.generateOBJ<T>(data)));
      stopLoading(true);
      return;
    } else if (data['error'] != null) {
      _streamManager.addDataToSinkByKey(T, PageData<T>.error(data['error']));
    } else {
      _streamManager.addDataToSinkByKey(T, PageData<String>.error("未知错误"));
    }
    stopLoading(false);

  }

  void dispose(key) {
    _streamManager.dispose(key);
  }

  void disposeAll() {
    _streamManager.disposeAll();
  }
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


