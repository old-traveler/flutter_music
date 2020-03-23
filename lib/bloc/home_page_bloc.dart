import 'package:music/api/api_url.dart' as api_url;
import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/banner_entity.dart';
import 'package:music/entity/elaborate_select_model_entity.dart';
import 'package:music/entity/hot_recommend_entity.dart';
import 'package:music/entity/song_sheet_entity.dart';
import 'package:music/entity/station_entity.dart';
import 'package:music/http/http_manager.dart';

class HomePageBloc with ResponseWorker {
  void fetchBannerData() {
    dealResponse<BannerEntity>(
        responseProvider: () =>
            HttpManager.getMockApi().get(api_url.bannerUrl));
  }

  void fetchHotRecommendData() {
    dealResponse<HotRecommendEntity>(
        responseProvider: () =>
            HttpManager.getInstance().get(api_url.hotRecommendUrl));
  }

  void fetchStationData() {
    dealResponse<StationEntity>(
        responseProvider: () =>
            HttpManager.getMockApi().get(api_url.stationUrl));
  }

  void fetchSongSheetData() {
    dealResponse<SongSheetEntity>(
        responseProvider: () =>
            HttpManager.getMockApi().get(api_url.songSheetUrl));
  }

  void fetchElaborateSelectData() {
    dealResponse<ElaborateSelectModelEntity>(
        responseProvider: () =>
            HttpManager.getInstance().get(api_url.elaborateUrl));
  }
}
