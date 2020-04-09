import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/flutter_music_plugin.dart';
import 'package:music/api/api_url.dart';
import 'package:music/entity/bean/music_info.dart';
import 'package:music/entity/song_play_entity.dart';
import 'package:music/generated/json/song_play_entity_helper.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/toast_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaySongsModel with ChangeNotifier {
  int _curState = MusicStateType.STATE_NONE;
  MusicSongInfo _curSongInfo;
  MusicState _musicState;
  bool sinkProgress = true;
  int _curPlayMode = MusicPlayMode.REPEAT_MODE_NONE;
  BuildContext _context;

  PlaySongsModel(this._context);

  /// 播放器当前状态信息
  MusicState get musicStateInfo => _musicState;

  /// 当前被播放的音乐数据信息
  MusicSongInfo get curSongInfo => _curSongInfo;

  /// 播放器当前状态
  int get curState => _curState;

  int get curPlayMode => _curPlayMode;

  bool _needUpdatePlayList = false;

  Future<dynamic> get playListInfo async {
    final songIdList = await MusicWrapper.singleton.getPlayListSongId();
    return songIdList
        .map((songId) => _songMap[songId])
        .where((data) => data != null)
        .toList();
  }

  StreamController<MusicState> _progressController =
      StreamController.broadcast();

  Stream<MusicState> get progressChangeStream => _progressController.stream;

  Map<String, MusicSongInfo> _songMap = {};

  void init() {
    MusicWrapper.singleton.initState();
    initPlayUrlProvider();
    MusicWrapper.singleton.getMusicStateStream().listen((data) {
      /// 状态改变和进度变化时才会回调用
      bool needNotify = false;
      final songInfo = _songMap[data.songId];
      if (songInfo != null && songInfo.hash != _curSongInfo?.hash) {
        /// 切换歌曲
        _curSongInfo = songInfo;
        print("切换歌曲" + _curSongInfo.songName);
        saveCurPlayingIndex(_curSongInfo.hash);
        needNotify = true;
        if (_needUpdatePlayList) {
          saveCurPlayingList();
        }
      }

      /// 状态发生改变，切不是因为网络缓冲原因时通知更新
      if (data.state != _curState &&
          !(data.state + _curState == 9 && data.state * _curState == 18)) {
        print("状态变化  ${data.state}  $_curState");
        needNotify = true;
      }
      _curState = data.state;
      _musicState = data;
      if (sinkProgress) {
        _progressController.sink.add(data);
      }
      if (needNotify) {
        notifyListeners();
      }
    });
  }

  void seekToProgress(int progress) {
    _progressController.sink.add(_musicState..position = progress);
  }

  void updatePortrait(String songId, List<String> list) {
    _songMap[songId]?.portrait = list;
    saveCurPlayingList();
  }

  @override
  void dispose() {
    super.dispose();
    _progressController.close();
    MusicWrapper.singleton.dispose();
  }

  void playSong(MusicSongInfo info) {
    assert(info != null && info.hash.isNotEmpty);
    _songMap[info.hash] = info;
    SongInfo songInfo = info.toSongInfo();
    MusicWrapper.singleton
        .playSong(songInfo.songId, songInfo.songUrl,
            duration: songInfo.duration)
        .whenComplete(() {
      saveCurPlayingList();
    });
  }

  bool playSongById(String songId) {
    if (_songMap.containsKey(songId)) {
      MusicWrapper.singleton.playMusicById(songId);
      return true;
    }
    return false;
  }

  void setPlayMode(int mode) {
    if (_curPlayMode == mode) return;
    _curPlayMode = mode;
    MusicWrapper.singleton.setPlayMusicMode(mode);
    saveCurPlayMode(mode);
  }

  void removeSongInfoById(String songId) {
    _songMap.remove(songId);
    MusicWrapper.singleton.removeSongInfoById(songId).whenComplete(() {
      saveCurPlayingList();
    });
  }

  void playOrPauseMusic() {
    MusicWrapper.singleton.playOrPauseMusic(songId: _curSongInfo.hash);
  }

  static isPlaying(PlaySongsModel model) {
    return model.curState == MusicStateType.STATE_PLAYING ||
        model.curState == MusicStateType.STATE_BUFFERING;
  }

  void saveCurPlayingList() async {
    _needUpdatePlayList = false;
    SharedPreferences sp = await SharedPreferences.getInstance();
    final List<MusicSongInfo> list = await playListInfo;
    Map<String, dynamic> data = {
      'data': list.map((info) => info.toJson()).toList()
    };
    String jsonString = json.encode(data);
    sp.setString('playList', jsonString);
  }

  void saveCurPlayingIndex(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('curPlayKey', key);
  }

  void saveCurPlayMode(int mode) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('curPlayMode', mode);
  }

  Future<void> initPlayList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String playListJson = sp.getString('playList');
    if (playListJson?.isNotEmpty != true) {
      return;
    }
    List<dynamic> musicSongInfoJson = json.decode(playListJson)['data'];
    List<MusicSongInfo> playList = musicSongInfoJson
        .map((jsonString) => MusicSongInfo.formJson(jsonString))
        .toList();
    String curPlayKey = sp.getString('curPlayKey');
    for (var value in playList) {
      if (value.hash == curPlayKey) {
        _curSongInfo = value;
      }
      _songMap[value.hash] = value;
    }
    MusicWrapper.singleton.loadMusicList(
        list: playList.map((data) => data.toSongInfo()).toList(),
        index: max(0, playList.indexOf(_curSongInfo)),
        pause: true);
    int mode = sp.getInt('curPlayMode') ?? MusicPlayMode.REPEAT_MODE_NONE;
    _curPlayMode = mode;
    MusicWrapper.singleton.setPlayMusicMode(mode);
  }

  void initPlayUrlProvider() {
    MusicWrapper.singleton.playUrlProvider = playUrlProviderImp;
  }

  Future<String> playUrlProviderImp(String songId) async {
    Response response =
        await HttpManager.getInstanceByUrl('https://wwwapi.kugou.com/')
            .get(getSongUrl(songId));
    print("https://wwwapi.kugou.com/" + getSongUrl(songId));
    print(response.toString());
    if (response == null) {
      ToastUtil.show(context: _context, msg: '网络不给力');
      return null;
    }
    SongPlayEntity entity = songPlayEntityFromJson(
        SongPlayEntity(), json.decode(response.toString()));
    if (entity.status == 1 && (entity?.data?.playUrl?.isNotEmpty == true)) {
      final duration =
          entity.data.isFreePart == 1 ? 60000 : entity.data.timelength;
      _songMap[songId]
        ..playUrl = entity.data.playUrl
        ..sizableCover =
            entity.data.authors[0].sizableAvatar.replaceFirst('{size}', '100')
        ..lyrics = entity.data.lyrics
        ..duration = duration;
      _needUpdatePlayList = true;
      return '${entity.data.playUrl}@$duration';
    }
    ToastUtil.show(context: _context, msg: '加载失败');
    return null;
  }
}

// ignore: sdk_version_extension_methods
extension MusicInfoConvert on MusicSongInfo {
  SongInfo toSongInfo() =>
      SongInfo(this.hash, this.playUrl, duration: this.duration);
}
