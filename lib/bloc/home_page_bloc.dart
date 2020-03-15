import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:music/entity/banner_entity.dart';
import 'package:music/entity/elaborate_select_model_entity.dart';
import 'package:music/entity/hot_recommend_entity.dart';
import 'package:music/entity/entity_factory.dart';
import 'package:music/entity/song_sheet_entity.dart';
import 'package:music/entity/station_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/stream_manager.dart';

class HomePageBloc  {
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

  Future fetchStationData() async {
    Response response = await HttpManager.getMockApi().get("station.json");
    _dealResponse<StationEntity>(response);
  }

  Future fetchSongSheetData() async {
    Response response = await HttpManager.getMockApi().get("song_sheet.json");
    _dealResponse<SongSheetEntity>(response);
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

  void addDataToSink(data) {
    _streamManager.addDataToSink(data);
  }

  void dispose(key) {
    _streamManager.dispose(key);
  }

  void disposeAll() {
    _streamManager.disposeAll();
  }
}
