// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:music/entity/user_entity.dart';
import 'package:music/generated/json/user_entity_helper.dart';
import 'package:music/entity/kg_song_sheet_list_entity.dart';
import 'package:music/generated/json/kg_song_sheet_list_entity_helper.dart';
import 'package:music/entity/song_play_entity.dart';
import 'package:music/generated/json/song_play_entity_helper.dart';
import 'package:music/entity/song_list_entity.dart';
import 'package:music/generated/json/song_list_entity_helper.dart';
import 'package:music/entity/kg_song_sheet_entity.dart';
import 'package:music/generated/json/kg_song_sheet_entity_helper.dart';
import 'package:music/entity/singer_portrait_entity.dart';
import 'package:music/generated/json/singer_portrait_entity_helper.dart';
import 'package:music/entity/hot_singer_entity.dart';
import 'package:music/generated/json/hot_singer_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case UserEntity:
			return userEntityFromJson(data as UserEntity, json) as T;			case UserUser:
			return userUserFromJson(data as UserUser, json) as T;			case KgSongSheetListEntity:
			return kgSongSheetListEntityFromJson(data as KgSongSheetListEntity, json) as T;			case KgSongSheetListList:
			return kgSongSheetListListFromJson(data as KgSongSheetListList, json) as T;			case KgSongSheetListListList:
			return kgSongSheetListListListFromJson(data as KgSongSheetListListList, json) as T;			case KgSongSheetListListListInfo:
			return kgSongSheetListListListInfoFromJson(data as KgSongSheetListListListInfo, json) as T;			case KgSongSheetListListListInfoTransParam:
			return kgSongSheetListListListInfoTransParamFromJson(data as KgSongSheetListListListInfoTransParam, json) as T;			case SongPlayEntity:
			return songPlayEntityFromJson(data as SongPlayEntity, json) as T;			case SongPlayData:
			return songPlayDataFromJson(data as SongPlayData, json) as T;			case SongPlayDataAuthor:
			return songPlayDataAuthorFromJson(data as SongPlayDataAuthor, json) as T;			case SongListEntity:
			return songListEntityFromJson(data as SongListEntity, json) as T;			case SongListData:
			return songListDataFromJson(data as SongListData, json) as T;			case SongListDataInfo:
			return songListDataInfoFromJson(data as SongListDataInfo, json) as T;			case KgSongSheetEntity:
			return kgSongSheetEntityFromJson(data as KgSongSheetEntity, json) as T;			case KgSongSheetPlist:
			return kgSongSheetPlistFromJson(data as KgSongSheetPlist, json) as T;			case KgSongSheetPlistList:
			return kgSongSheetPlistListFromJson(data as KgSongSheetPlistList, json) as T;			case KgSongSheetPlistListInfo:
			return kgSongSheetPlistListInfoFromJson(data as KgSongSheetPlistListInfo, json) as T;			case KgSongSheetPlistListInfoSong:
			return kgSongSheetPlistListInfoSongFromJson(data as KgSongSheetPlistListInfoSong, json) as T;			case KgSongSheetPlistListInfoSongsTransParam:
			return kgSongSheetPlistListInfoSongsTransParamFromJson(data as KgSongSheetPlistListInfoSongsTransParam, json) as T;			case KgSongSheetPlistListInfoTransParam:
			return kgSongSheetPlistListInfoTransParamFromJson(data as KgSongSheetPlistListInfoTransParam, json) as T;			case SingerPortraitEntity:
			return singerPortraitEntityFromJson(data as SingerPortraitEntity, json) as T;			case SingerPortraitData:
			return singerPortraitDataFromJson(data as SingerPortraitData, json) as T;			case SingerPortraitDataAlbum:
			return singerPortraitDataAlbumFromJson(data as SingerPortraitDataAlbum, json) as T;			case SingerPortraitDataAlbumImgs:
			return singerPortraitDataAlbumImgsFromJson(data as SingerPortraitDataAlbumImgs, json) as T;			case SingerPortraitDataAuthor:
			return singerPortraitDataAuthorFromJson(data as SingerPortraitDataAuthor, json) as T;			case SingerPortraitDataAuthorImgs:
			return singerPortraitDataAuthorImgsFromJson(data as SingerPortraitDataAuthorImgs, json) as T;			case SingerPortraitDataAuthorImgs4:
			return singerPortraitDataAuthorImgs4FromJson(data as SingerPortraitDataAuthorImgs4, json) as T;			case HotSingerEntity:
			return hotSingerEntityFromJson(data as HotSingerEntity, json) as T;			case HotSingerData:
			return hotSingerDataFromJson(data as HotSingerData, json) as T;			case HotSingerDataInfo:
			return hotSingerDataInfoFromJson(data as HotSingerDataInfo, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case UserEntity:
			return userEntityToJson(data as UserEntity);			case UserUser:
			return userUserToJson(data as UserUser);			case KgSongSheetListEntity:
			return kgSongSheetListEntityToJson(data as KgSongSheetListEntity);			case KgSongSheetListList:
			return kgSongSheetListListToJson(data as KgSongSheetListList);			case KgSongSheetListListList:
			return kgSongSheetListListListToJson(data as KgSongSheetListListList);			case KgSongSheetListListListInfo:
			return kgSongSheetListListListInfoToJson(data as KgSongSheetListListListInfo);			case KgSongSheetListListListInfoTransParam:
			return kgSongSheetListListListInfoTransParamToJson(data as KgSongSheetListListListInfoTransParam);			case SongPlayEntity:
			return songPlayEntityToJson(data as SongPlayEntity);			case SongPlayData:
			return songPlayDataToJson(data as SongPlayData);			case SongPlayDataAuthor:
			return songPlayDataAuthorToJson(data as SongPlayDataAuthor);			case SongListEntity:
			return songListEntityToJson(data as SongListEntity);			case SongListData:
			return songListDataToJson(data as SongListData);			case SongListDataInfo:
			return songListDataInfoToJson(data as SongListDataInfo);			case KgSongSheetEntity:
			return kgSongSheetEntityToJson(data as KgSongSheetEntity);			case KgSongSheetPlist:
			return kgSongSheetPlistToJson(data as KgSongSheetPlist);			case KgSongSheetPlistList:
			return kgSongSheetPlistListToJson(data as KgSongSheetPlistList);			case KgSongSheetPlistListInfo:
			return kgSongSheetPlistListInfoToJson(data as KgSongSheetPlistListInfo);			case KgSongSheetPlistListInfoSong:
			return kgSongSheetPlistListInfoSongToJson(data as KgSongSheetPlistListInfoSong);			case KgSongSheetPlistListInfoSongsTransParam:
			return kgSongSheetPlistListInfoSongsTransParamToJson(data as KgSongSheetPlistListInfoSongsTransParam);			case KgSongSheetPlistListInfoTransParam:
			return kgSongSheetPlistListInfoTransParamToJson(data as KgSongSheetPlistListInfoTransParam);			case SingerPortraitEntity:
			return singerPortraitEntityToJson(data as SingerPortraitEntity);			case SingerPortraitData:
			return singerPortraitDataToJson(data as SingerPortraitData);			case SingerPortraitDataAlbum:
			return singerPortraitDataAlbumToJson(data as SingerPortraitDataAlbum);			case SingerPortraitDataAlbumImgs:
			return singerPortraitDataAlbumImgsToJson(data as SingerPortraitDataAlbumImgs);			case SingerPortraitDataAuthor:
			return singerPortraitDataAuthorToJson(data as SingerPortraitDataAuthor);			case SingerPortraitDataAuthorImgs:
			return singerPortraitDataAuthorImgsToJson(data as SingerPortraitDataAuthorImgs);			case SingerPortraitDataAuthorImgs4:
			return singerPortraitDataAuthorImgs4ToJson(data as SingerPortraitDataAuthorImgs4);			case HotSingerEntity:
			return hotSingerEntityToJson(data as HotSingerEntity);			case HotSingerData:
			return hotSingerDataToJson(data as HotSingerData);			case HotSingerDataInfo:
			return hotSingerDataInfoToJson(data as HotSingerDataInfo);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'UserEntity':
			return UserEntity().fromJson(json);			case 'UserUser':
			return UserUser().fromJson(json);			case 'KgSongSheetListEntity':
			return KgSongSheetListEntity().fromJson(json);			case 'KgSongSheetListList':
			return KgSongSheetListList().fromJson(json);			case 'KgSongSheetListListList':
			return KgSongSheetListListList().fromJson(json);			case 'KgSongSheetListListListInfo':
			return KgSongSheetListListListInfo().fromJson(json);			case 'KgSongSheetListListListInfoTransParam':
			return KgSongSheetListListListInfoTransParam().fromJson(json);			case 'SongPlayEntity':
			return SongPlayEntity().fromJson(json);			case 'SongPlayData':
			return SongPlayData().fromJson(json);			case 'SongPlayDataAuthor':
			return SongPlayDataAuthor().fromJson(json);			case 'SongListEntity':
			return SongListEntity().fromJson(json);			case 'SongListData':
			return SongListData().fromJson(json);			case 'SongListDataInfo':
			return SongListDataInfo().fromJson(json);			case 'KgSongSheetEntity':
			return KgSongSheetEntity().fromJson(json);			case 'KgSongSheetPlist':
			return KgSongSheetPlist().fromJson(json);			case 'KgSongSheetPlistList':
			return KgSongSheetPlistList().fromJson(json);			case 'KgSongSheetPlistListInfo':
			return KgSongSheetPlistListInfo().fromJson(json);			case 'KgSongSheetPlistListInfoSong':
			return KgSongSheetPlistListInfoSong().fromJson(json);			case 'KgSongSheetPlistListInfoSongsTransParam':
			return KgSongSheetPlistListInfoSongsTransParam().fromJson(json);			case 'KgSongSheetPlistListInfoTransParam':
			return KgSongSheetPlistListInfoTransParam().fromJson(json);			case 'SingerPortraitEntity':
			return SingerPortraitEntity().fromJson(json);			case 'SingerPortraitData':
			return SingerPortraitData().fromJson(json);			case 'SingerPortraitDataAlbum':
			return SingerPortraitDataAlbum().fromJson(json);			case 'SingerPortraitDataAlbumImgs':
			return SingerPortraitDataAlbumImgs().fromJson(json);			case 'SingerPortraitDataAuthor':
			return SingerPortraitDataAuthor().fromJson(json);			case 'SingerPortraitDataAuthorImgs':
			return SingerPortraitDataAuthorImgs().fromJson(json);			case 'SingerPortraitDataAuthorImgs4':
			return SingerPortraitDataAuthorImgs4().fromJson(json);			case 'HotSingerEntity':
			return HotSingerEntity().fromJson(json);			case 'HotSingerData':
			return HotSingerData().fromJson(json);			case 'HotSingerDataInfo':
			return HotSingerDataInfo().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'UserEntity':
			return List<UserEntity>();			case 'UserUser':
			return List<UserUser>();			case 'KgSongSheetListEntity':
			return List<KgSongSheetListEntity>();			case 'KgSongSheetListList':
			return List<KgSongSheetListList>();			case 'KgSongSheetListListList':
			return List<KgSongSheetListListList>();			case 'KgSongSheetListListListInfo':
			return List<KgSongSheetListListListInfo>();			case 'KgSongSheetListListListInfoTransParam':
			return List<KgSongSheetListListListInfoTransParam>();			case 'SongPlayEntity':
			return List<SongPlayEntity>();			case 'SongPlayData':
			return List<SongPlayData>();			case 'SongPlayDataAuthor':
			return List<SongPlayDataAuthor>();			case 'SongListEntity':
			return List<SongListEntity>();			case 'SongListData':
			return List<SongListData>();			case 'SongListDataInfo':
			return List<SongListDataInfo>();			case 'KgSongSheetEntity':
			return List<KgSongSheetEntity>();			case 'KgSongSheetPlist':
			return List<KgSongSheetPlist>();			case 'KgSongSheetPlistList':
			return List<KgSongSheetPlistList>();			case 'KgSongSheetPlistListInfo':
			return List<KgSongSheetPlistListInfo>();			case 'KgSongSheetPlistListInfoSong':
			return List<KgSongSheetPlistListInfoSong>();			case 'KgSongSheetPlistListInfoSongsTransParam':
			return List<KgSongSheetPlistListInfoSongsTransParam>();			case 'KgSongSheetPlistListInfoTransParam':
			return List<KgSongSheetPlistListInfoTransParam>();			case 'SingerPortraitEntity':
			return List<SingerPortraitEntity>();			case 'SingerPortraitData':
			return List<SingerPortraitData>();			case 'SingerPortraitDataAlbum':
			return List<SingerPortraitDataAlbum>();			case 'SingerPortraitDataAlbumImgs':
			return List<SingerPortraitDataAlbumImgs>();			case 'SingerPortraitDataAuthor':
			return List<SingerPortraitDataAuthor>();			case 'SingerPortraitDataAuthorImgs':
			return List<SingerPortraitDataAuthorImgs>();			case 'SingerPortraitDataAuthorImgs4':
			return List<SingerPortraitDataAuthorImgs4>();			case 'HotSingerEntity':
			return List<HotSingerEntity>();			case 'HotSingerData':
			return List<HotSingerData>();			case 'HotSingerDataInfo':
			return List<HotSingerDataInfo>();    }
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