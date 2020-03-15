

import 'package:music/entity/search_song_entity.dart';
import 'package:music/entity/song_sheet_entity.dart';
import 'package:music/entity/station_entity.dart';
import 'association_entity.dart';
import 'banner_entity.dart';
import 'elaborate_select_model_entity.dart';
import 'hot_recommend_entity.dart';
import 'hot_search_entity.dart';
import 'live_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HotRecommendEntity") {
      return HotRecommendEntity.fromJson(json) as T;
    } else if (T.toString() == "BannerEntity") {
      return BannerEntity.fromJson(json) as T;
    } else if (T.toString() == "ElaborateSelectModelEntity") {
      return ElaborateSelectModelEntity.fromJson(json) as T;
    } else if (T.toString() == "SongSheetEntity") {
      return SongSheetEntity.fromJson(json) as T;
    } else if (T.toString() == "StationEntity") {
      return StationEntity.fromJson(json) as T;
    } else if (T.toString() == "AssociationEntity") {
      return AssociationEntity.fromJson(json) as T;
    } else if (T.toString() == "HotSearchEntity") {
      return HotSearchEntity.fromJson(json) as T;
    } else if (T.toString() == "SearchSongEntity") {
      return SearchSongEntity.fromJson(json) as T;
    } else if (T.toString() == "LiveEntity") {
      return LiveEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}