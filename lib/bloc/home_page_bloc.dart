import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:music/entity/banner_entity.dart';
import 'package:music/entity/elaborate_select_model_entity.dart';
import 'package:music/entity/hot_recommend_entity.dart';
import 'package:music/entity/entity_factory.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/stream_manager.dart';

class HomePageBloc implements StreamManager {
  final StreamManager _streamManager = StreamManager();

  StreamManager get streamManager => _streamManager;

  Future fetchBannerData() async {
    Response response = await HttpManager.getMockApi().get("banner.json");
    _dealResponse<BannerEntity>(response);
  }

  Future fetchHotRecommendData() async {
    Response response = await HttpManager.getInstance()
        .get("tag/recommend?showtype=3&apiver=2&plat=0");
    _dealResponse<HotRecommendEntity>(response);
  }

  Future fetchElaborateSelectData() async {
    Response response =
        await HttpManager.getInstance().get("tag/list?pid=0&apiver=2&plat=0");
    _dealResponse<ElaborateSelectModelEntity>(response);
  }

  void _dealResponse<T>(Response response) {
    if (response == null) {
      //网络请求失败
      return;
    }
    dynamic data = json.decode(response.toString());
    if (data == null) {
      //json数据为空
      return;
    }
    if (data['status'] == 1) {
      addDataToSink(EntityFactory.generateOBJ<T>(data));
    } else if (data['error'] != null) {
      //打印错误信息
    } else {
      //未知错误
    }
  }

  @override
  void addDataToSink(data) {
    _streamManager.addDataToSink(data);
  }

  @override
  void dispose(key) {
    _streamManager.dispose(key);
  }

  @override
  void disposeAll() {
    _streamManager.disposeAll();
  }
}
