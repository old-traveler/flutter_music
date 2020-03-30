import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/flutter_music_plugin.dart';

class PlaySongsModel with ChangeNotifier {
  int _curState = MusicStateType.STATE_NONE;
  MusicSongInfo _curSongInfo;
  MusicState _musicState;
  bool sinkProgress = true;

  /// 播放器当前状态信息
  MusicState get musicStateInfo => _musicState;

  /// 当前被播放的音乐数据信息
  MusicSongInfo get curSongInfo => _curSongInfo;

  /// 播放器当前状态
  int get curState => _curState;

  StreamController<MusicState> _progressController =
      StreamController.broadcast();

  Stream<MusicState> get progressChangeStream => _progressController.stream;

  Map<String, MusicSongInfo> _songMap = {};

  void init() {
    MusicWrapper.singleton.initState();
    MusicWrapper.singleton.getMusicStateStream().listen((data) {
      /// 状态改变和进度变化时才会回调用
      bool needNotify = false;
      final songInfo = _songMap[data.songId];
      if (songInfo != null && songInfo.hash != _curSongInfo?.hash) {
        /// 切换歌曲
        _curSongInfo = songInfo;
        print("切换歌曲" + _curSongInfo.songName);
        needNotify = true;
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
    MusicWrapper.singleton.playSongByInfo(info.toSongInfo());
  }

  bool playSongById(String songId) {
    if (_songMap.containsKey(songId)) {
      MusicWrapper.singleton.playMusicById(songId);
      return true;
    }
    return false;
  }
}

// ignore: sdk_version_extension_methods
extension MusicInfoConvert on MusicSongInfo {
  SongInfo toSongInfo() =>
      SongInfo(this.hash, this.playUrl, duration: this.duration);
}

class MusicSongInfo {
  String hash;
  String playUrl;
  List<String> portrait;
  String albumId;
  String filename;
  String albumAudioId;
  String sizableCover;
  String songName;
  String singerName;
  String lyrics;
  int duration;

  MusicSongInfo(
      {this.hash,
      this.playUrl,
      this.portrait,
      this.albumId,
      this.filename,
      this.albumAudioId,
      this.sizableCover,
      this.songName,
      this.singerName,
      this.lyrics,
      this.duration = -1});
}
