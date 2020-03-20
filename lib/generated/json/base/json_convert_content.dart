// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:music/entity/hot_singer_entity.dart';
import 'package:music/generated/json/hot_singer_entity_helper.dart';
import 'package:music/entity/song_list_entity.dart';
import 'package:music/generated/json/song_list_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case HotSingerEntity:
			return hotSingerEntityFromJson(data as HotSingerEntity, json) as T;			case HotSingerData:
			return hotSingerDataFromJson(data as HotSingerData, json) as T;			case HotSingerDataInfo:
			return hotSingerDataInfoFromJson(data as HotSingerDataInfo, json) as T;			case SongListEntity:
			return songListEntityFromJson(data as SongListEntity, json) as T;			case SongListData:
			return songListDataFromJson(data as SongListData, json) as T;			case SongListDataInfo:
			return songListDataInfoFromJson(data as SongListDataInfo, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case HotSingerEntity:
			return hotSingerEntityToJson(data as HotSingerEntity);			case HotSingerData:
			return hotSingerDataToJson(data as HotSingerData);			case HotSingerDataInfo:
			return hotSingerDataInfoToJson(data as HotSingerDataInfo);			case SongListEntity:
			return songListEntityToJson(data as SongListEntity);			case SongListData:
			return songListDataToJson(data as SongListData);			case SongListDataInfo:
			return songListDataInfoToJson(data as SongListDataInfo);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'HotSingerEntity':
			return HotSingerEntity().fromJson(json);			case 'HotSingerData':
			return HotSingerData().fromJson(json);			case 'HotSingerDataInfo':
			return HotSingerDataInfo().fromJson(json);			case 'SongListEntity':
			return SongListEntity().fromJson(json);			case 'SongListData':
			return SongListData().fromJson(json);			case 'SongListDataInfo':
			return SongListDataInfo().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'HotSingerEntity':
			return List<HotSingerEntity>();			case 'HotSingerData':
			return List<HotSingerData>();			case 'HotSingerDataInfo':
			return List<HotSingerDataInfo>();			case 'SongListEntity':
			return List<SongListEntity>();			case 'SongListData':
			return List<SongListData>();			case 'SongListDataInfo':
			return List<SongListDataInfo>();    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}